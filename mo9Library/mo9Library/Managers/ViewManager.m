//
//  ViewManager.m
//  Mo9Client
//
//  Created by ChenJian on 2017/4/25.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "ViewManager.h"
#import "BaseNavViewController.h"
#import "UIImage+TBCityIconFont.h"
@interface ViewManager()
@property (nonatomic, strong) NSDictionary *vcDic;
@end


#define kKey_StoryboardName @"storyboardName"
#define kKey_ClassName @"className"
#define kKey_title @"title"

@implementation ViewManager

+ (BaseManager *)manager {
    static ViewManager *__manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[ViewManager alloc] init];
    });
    return __manager;
}

- (id)init {
    self = [super init];
    if (self) {
        [self initVcDic];
    }
    return self;
}

- (NSArray *)baseViewControllers {
    NSArray *tempArr = [self.vcDic objectForKey:@"TabVC"];
    NSMutableArray *vcArr = [NSMutableArray arrayWithCapacity:tempArr.count];
    for (NSDictionary *dic in tempArr) {
        NSString *storyboardName = [dic objectForKey:kKey_StoryboardName];
        NSString *vcName = [dic objectForKey:kKey_ClassName];
        NSString *title = [dic objectForKey:kKey_title];
        NSString *imageOff = dic[@"images"][@"image_off"];
        NSString *imageOn = dic[@"images"][@"image_on"];
        BaseViewController *vc = [self getVCWithStoryboardName:storyboardName vcName:vcName];
        BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:vc];
        vc.title = title;
        [self setTabBarItem:nav.tabBarItem withImageName:imageOff isSelected:NO];
        [self setTabBarItem:nav.tabBarItem withImageName:imageOn isSelected:YES];
        [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
        [nav.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [[Infrastructure getConfigManager] tabbarTitleColor] }
                                      forState:UIControlStateNormal];
        [nav.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [[Infrastructure getConfigManager] tabbarSelectedTitleColor] }
                                      forState:UIControlStateSelected];

        [vcArr addObject:nav];
    }
    return [NSArray arrayWithArray:vcArr];
}

- (id)loginViewController {
    NSDictionary *dic = [self.vcDic objectForKey:@"Login"];
    NSString *storyboardName = [dic objectForKey:kKey_StoryboardName];
    NSString *vcName = [dic objectForKey:kKey_ClassName];
    BaseViewController *vc = [self getVCWithStoryboardName:storyboardName vcName:vcName];
    BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:vc];
    return nav;
}

- (BaseViewController *)getVCWithStoryboardName:(NSString *)storyName vcName:(NSString *)vcName{
    BaseViewController *vc;
    if (storyName.length>0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:storyName bundle:nil];
        vc = (BaseViewController *)[sb instantiateViewControllerWithIdentifier:vcName];
    }else {
        Class className = [CommonFunction classWithName:vcName];
        vc = (BaseViewController *)[[className alloc] init];
    }
    return vc;
}

- (void)setTabBarItem:(UITabBarItem *)tabBarItem withImageName:(NSString *)imgName isSelected:(BOOL)isSelected {
    UIImage *image;
    if ([imgName containsString:@".png"]) {
        image = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        if (isSelected) {
            tabBarItem.selectedImage = image;
        }else {
            tabBarItem.image = image;
        }
    }else {
        TBCityIconInfo *info = [TBCityIconInfo iconInfoWithText:imgName size:24 color:nil];
        image = [UIImage iconWithInfo:info];
        if (isSelected) {
            tabBarItem.selectedImage = image;
        }else {
            tabBarItem.image = image;
        }
    }
    Log(@"tabimage:%@",image);
}


#pragma ---- private methods ----
- (void)initVcDic {
    self.vcDic = [NSDictionary dictionaryWithContentsOfURL:[[Infrastructure getResManager] vcConfigPath]];
}

@end
