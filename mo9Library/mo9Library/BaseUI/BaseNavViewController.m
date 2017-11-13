//
//  BaseNavViewController.m
//  mo9Library
//
//  Created by ChenJian on 2017/8/4.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationBar] setBarTintColor:[[Infrastructure getConfigManager] navbarBgColor]];
    [[self navigationBar] setTranslucent:NO];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys: [[Infrastructure getConfigManager] navbarTitleColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"HelveticaNeue" size:18.0f], NSFontAttributeName, nil];
    
    [[self navigationBar] setTitleTextAttributes:attributes];
    
    [[self navigationBar] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [[self navigationBar] setShadowImage:[[UIImage alloc] init]];
    
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.viewControllers count] > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count == 1) {
        return NO;
    }else {
        return YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
