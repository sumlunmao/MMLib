//
//  LibsManager.m
//  Mo9Client
//
//  Created by ChenJian on 2017/6/8.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "LibsManager.h"
@interface LibsManager()
{
    NSMutableArray *mArr;
}
@end

@implementation LibsManager

+ (BaseManager *)manager {
    static LibsManager *__manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[LibsManager alloc] init];
    });
    return __manager;
}

- (NSArray *)shareTitles {
    if (!mArr) {
        mArr = [NSMutableArray array];
        if ([Infrastructure getConfigManager].weiboAppId.length>0) {
            [mArr addObject:@"新浪微博"];
        }
        if ([Infrastructure getConfigManager].qqAppId.length > 0) {
            [mArr addObject:@"QQ"];
        }
        if ([Infrastructure getConfigManager].weixinAppId.length > 0) {
            [mArr addObject:@"微信好友"];
            [mArr addObject:@"朋友圈"];
        }
    }
    return [NSArray arrayWithArray:mArr];
}

//
//- (UMSocialPlatformType)platformAtindex:(NSInteger)index {
//    NSString *title = [mArr objectAtIndex:index];
//    UMSocialPlatformType type = UMSocialPlatformType_UnKnown;
//    if ([title isEqualToString:@"新浪微博"]) {
//        type = UMSocialPlatformType_Sina;
//    }
//    if ([title isEqualToString:@"QQ"]) {
//        type = UMSocialPlatformType_QQ;
//    }
//    if ([title isEqualToString:@"朋友圈"]) {
//        type = UMSocialPlatformType_WechatTimeLine;
//    }
//    if ([title isEqualToString:@"微信好友"]) {
//        type = UMSocialPlatformType_WechatSession;
//    }
//    return type;
//}

@end
