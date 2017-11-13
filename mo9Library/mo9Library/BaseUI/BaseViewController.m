//
//  BaseViewController.m
//  Mo9SDK
//
//  Created by ChenJian on 15/5/13.
//  Copyright (c) 2015年 mo9. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavViewController.h"


@interface BaseViewController ()<UIGestureRecognizerDelegate>
{
    BOOL isHeader;
}

@end

@implementation BaseViewController

- (void)dealloc {
    Log(@"dealloc:%@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self baseDealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[Infrastructure getConfigManager] mainBgColor];
    if (self.navigationController) {
        if ([self.navigationController.viewControllers count] > 1) {
            [self addBackBarButton:YES];
        }
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initData];
    [self initUI];
}

- (void)baseDealloc {
}

- (void)initData {
    
}

- (void)initUI {
    
}

#pragma mark ---- 通知相关 ----
- (void)notificationTokenInvalid:(NSNotification*)notification {
    
}

- (void)postNotification:(NSString *)name object:(id)obj {
    [self postNotification:name object:obj userInfo:nil];
}

- (void)postNotification:(NSString *)name object:(id)obj userInfo:(NSDictionary *)dic {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj userInfo:dic];
}

- (void)addNotification:(NSString *)name method:(SEL)method object:(id)obj{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:method name:name object:obj];
}


- (void)addBackBarButton:(BOOL)add {
    //    [self.navigationItem setHidesBackButton:YES];
    if (add) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemWithTarget:self selector:@selector(backAction)];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)backAction {
    [self backActionWithAnimate:YES];
}

- (void)backActionWithAnimate:(BOOL)animated {
    [self.navigationController popViewControllerAnimated:animated];
}

- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addDismssBtnIsLeft:(BOOL)isLeft {
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = @[[UIBarButtonItem rectBarButtonItemWithTitle:@"取消" target:self selector:@selector(dismissVC)]];
    }else {
        self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem rectBarButtonItemWithTitle:@"取消" target:self selector:@selector(dismissVC)]];
    }
}


#pragma mark - notification selector



#pragma mark ---- xib ----
/**
 * xib
 */
- (void)pushVcName:(NSString*)vcName params:(NSDictionary*)parmas {
    [self pushVcName:vcName params:parmas resultBlock:nil animated:YES];
}

- (void)pushVcName:(NSString*)vcName params:(NSDictionary*)parmas resultBlock:(VcCallbackBlock)block {
    [self pushVcName:vcName params:parmas resultBlock:block animated:YES];
}

- (void)pushVcName:(NSString*)vcName params:(NSDictionary*)parmas resultBlock:(VcCallbackBlock)block animated:(BOOL)animated {
    BaseViewController *vc = (BaseViewController *)[[[CommonFunction classWithName:vcName] alloc] init];
    vc.bundle = [NSDictionary dictionaryWithDictionary:parmas];
    vc.callbackBlock = block;
    [self.navigationController pushViewController:vc animated:animated];
}

- (void)presentVcName:(NSString*)vcName params:(NSDictionary*)parmas {
    [self presentVcName:vcName params:parmas resultBlock:nil];
}

- (void)presentVcName:(NSString*)vcName params:(NSDictionary*)parmas resultBlock:(VcCallbackBlock)block {
    BaseViewController *vc = (BaseViewController *)[[CommonFunction classWithName:vcName] init];
    vc.bundle = [NSDictionary dictionaryWithDictionary:parmas];
    vc.callbackBlock = block;
    
    BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark ---- storyboard ----

- (void)pushNextPage:(NSString*)storyName vcName:(NSString*)vcName params:(NSDictionary*)parmas {
    [self pushNextPage:storyName vcName:vcName params:parmas animated:YES resultBlock:nil];
}

- (void)pushNextPage:(NSString *)storyName vcName:(NSString *)vcName params:(NSDictionary *)parmas resultBlock:(VcCallbackBlock)block{
    [self pushNextPage:storyName vcName:vcName params:parmas animated:YES resultBlock:block];
}

- (void)pushNextPage:(NSString *)storyName vcName:(NSString *)vcName params:(NSDictionary *)parmas animated:(BOOL)animated resultBlock:(VcCallbackBlock)block{
    UIStoryboard* story;
    
    if([storyName length] == 0)
        story = self.storyboard;
    else
        story = [UIStoryboard storyboardWithName:storyName bundle:nil];
    
    BaseViewController* vc;
    
    if([vcName length] == 0)
        vc = (BaseViewController *)[story instantiateInitialViewController];
    else
        vc = (BaseViewController *)[story instantiateViewControllerWithIdentifier:vcName];
    
    vc.bundle = parmas;
    vc.callbackBlock = block;
    
    [self.navigationController pushViewController:vc animated:animated];
}

- (BaseViewController *)getVCWithStoryboardName:(NSString *)storyName vcName:(NSString *)vcName {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyName bundle:nil];
    BaseViewController *vc;
    if (vcName.length == 0) {
        vc = (BaseViewController *)[sb instantiateInitialViewController];
    }else {
        vc = (BaseViewController *)[sb instantiateViewControllerWithIdentifier:vcName];
    }
    return vc;
}

- (BaseViewController *)getVCWithVcName:(NSString *)vcName {
    BaseViewController *vc;
    if (self.storyboard) {
        if (vcName.length == 0) {
            vc = (BaseViewController *)[self.storyboard instantiateInitialViewController];
        }else {
            vc = (BaseViewController *)[self.storyboard instantiateViewControllerWithIdentifier:vcName];
        }
    }else {
        vc = (BaseViewController *)[[[CommonFunction classWithName:vcName] alloc] init];
    }
    return vc;
}

- (void)presentNextPage:(NSString *)storyName vcName:(NSString *)vcName params:(NSDictionary *)parmas {
    [self presentNextPage:storyName vcName:vcName params:parmas resultBlock:nil];
}

- (void)presentNextPage:(NSString *)storyName vcName:(NSString *)vcName params:(NSDictionary *)parmas resultBlock:(VcCallbackBlock)block{
    UIStoryboard* story;
    
    if([storyName length] == 0)
        story = self.storyboard;
    else
        story = [UIStoryboard storyboardWithName:storyName bundle:nil];
    
    BaseViewController* vc;
    
    if([vcName length] == 0)
        vc = [story instantiateInitialViewController];
    else
        vc = [story instantiateViewControllerWithIdentifier:vcName];
    
    vc.bundle = parmas;
    vc.callbackBlock = block;
    
    BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
