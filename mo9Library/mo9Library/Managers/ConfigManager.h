//
//  ConfigManager.h
//  Mo9Client
//
//  Created by ChenJian on 2017/4/17.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseManager.h"
#import "Mo9Contants.h"


@interface ConfigManager : BaseManager



#pragma mark ---- Environment config ----

@property (nonatomic, strong, readonly) NSDictionary *configDic;
@property (nonatomic, strong, readonly) NSDictionary *styleConfigDic;
@property (nonatomic, strong, readonly) NSDictionary *serverDic;
@property (nonatomic, strong, readonly) NSDictionary *errorCodeDic;

#pragma mark ---- Project config --- 

- (NSString *)appVersion;

- (NSString *)appBuildVersion;

// app名称
- (NSString *)displayName;

#pragma mark ---- style config ----

- (UIStatusBarStyle)statusBarStyle;

#pragma mark ---- 常量配置 ----

- (NSString *)appName;

- (NSString *)umengAppKey;

- (NSString *)weixinAppId;
- (NSString *)weixinAppSecret;

- (NSString *)weiboAppId;
- (NSString *)weiboAppSecret;

- (NSString *)qqAppId;
- (NSString *)qqAppSecret;

- (NSString *)zhichiKey;

- (NSString *)baiDuMapAK;

- (NSString *)ocrId;

- (NSString *)ocrSecret;

- (NSString *)mySchemeUrl;

- (NSString *)homeUrl;

- (NSString *)appstoreUrl;

- (NSString *)platform;

//统计私钥
- (NSString *)collectionKey;

//11:信用钱包  21：飞鼠贷  31：飞鼠贷PRO
- (NSString *)client_Id;

//防盗刷签名私钥
- (NSString *)securityKey;

/**合同和服务协议预览的私钥*/
- (NSString *)contractKey;


- (NSString *)productName;

- (NSString *)umengChannel;

- (NSString *)emgKey;

//匿名账户
- (NSString *)userName;
- (NSString *)userPwd;

// 版本说明
- (NSArray *)versionExplain;

// 引导图
// iphone 4
- (NSArray *)guideImagesIphone4;
// iphone retina
- (NSArray *)guideImagesIphoneOther;
// 是否显示 pageControl
- (BOOL)isGuideImagesShowPageControl;
// pageControl 的 currentPageIndicatorTintColor
- (NSString *)guideImagesCurrentPageIndicatorTintColor;
// pageControl 的 pageIndicatorTintColor
- (NSString *)guideImagesPageIndicatorTintColor;

// 广告页
// code
- (NSString *)advertisementStartCode;
- (NSString *)advertisementPopCode;
- (NSString *)advertisementMarqueeCode;
- (NSString *)advertisementBannerCode;

// 模型文件路径
- (NSString *)advertisementStartPath;
- (NSString *)advertisementPopPath;
- (NSString *)advertisementMarqueePath;
- (NSString *)advertisementBannerPath;


@end
