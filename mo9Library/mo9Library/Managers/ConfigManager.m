//
//  ConfigManager.m
//  Mo9Client
//
//  Created by ChenJian on 2017/4/17.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "ConfigManager.h"

#define kUmengKey @"umengappkey"

@interface ConfigManager()
{

}

@end

@implementation ConfigManager
@synthesize configDic = _configDic,styleConfigDic = _styleConfigDic,serverDic = _serverDic,errorCodeDic = _errorCodeDic;

+ (ConfigManager *)manager {
    static ConfigManager *__manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[ConfigManager alloc] init];
    });
    return __manager;
}

- (id)init {
    self = [super init];
    if (self) {
        
    };
    return self;
}

#pragma mark ---- Project config ---

- (NSString *)appVersion {
    NSString *bundleVerion = @"CFBundleShortVersionString";
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:bundleVerion];
}

- (NSString *)appBuildVersion {
    NSString *bundleVerion = @"CFBundleVersion";
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:bundleVerion];
}

- (NSString *)displayName {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *displayName = [infoDic objectForKey:@"CFBundleDisplayName"];
    return displayName;
}

#pragma mark ---- style config ----

- (UIStatusBarStyle)statusBarStyle {
    if ([self systemConfig][@"statusbartextcolorstyle"] == 0) {
        return UIStatusBarStyleDefault;//黑色字
    }else {
        return UIStatusBarStyleLightContent;//白色字
    }
}


#pragma mark ---- 常量配置 ----
- (NSString *)appName {
    return [self systemConfig][@"appName"];
}

- (NSString *)umengAppKey {
    return [self thirdConfig][@"umeng"][@"umengAppKey"];
}

- (NSString *)weixinAppId {
    return [self thirdConfig][@"weixin"][@"weixinAppId"];
}

- (NSString *)weixinAppSecret {
    return [self thirdConfig][@"weixin"][@"weixinAppSecret"];
}

- (NSString *)weiboAppId {
    return [self thirdConfig][@"weibo"][@"weiboAppId"];
}

- (NSString *)weiboAppSecret {
    return [self thirdConfig][@"weibo"][@"weiboAppSecret"];
}

- (NSString *)qqAppId {
    return [self thirdConfig][@"qq"][@"qqAppId"];
}

- (NSString *)qqAppSecret {
    return [self thirdConfig][@"qq"][@"qqAppSecret"];
}

- (NSString *)zhichiKey {
    return [self thirdConfig][@"zhichi"][@"zhichiKey"];
}

- (NSString *)baiDuMapAK {
    return [self thirdConfig][@"baidumap"][@"baiDuMapAK"];
}
- (NSString *)ocrId {
    return [self thirdConfig][@"ocr"][@"ocrId"];
}
- (NSString *)ocrSecret {
    return [self thirdConfig][@"ocr"][@"ocrSecret"];
}
- (NSString *)mySchemeUrl {
    return [self systemConfig][@"mySchemeUrl"];
}

- (NSString *)homeUrl {
    return [self systemConfig][@"homeUrl"];
}

- (NSString *)appstoreUrl {
    return [self systemConfig][@"appstoreUrl"];
}

- (NSString *)platform {
    return [self systemConfig][@"platform"];
}

//统计私钥
- (NSString *)collectionKey {
    return [self systemConfig][@"collectionKey"];
}

//11:信用钱包  21：飞鼠贷  31：飞鼠贷PRO
- (NSString *)client_Id {
    return [self systemConfig][@"client_Id"];
}

//防盗刷签名私钥
- (NSString *)securityKey {
    return [self systemConfig][@"securityKey"];
}

/**合同和服务协议预览的私钥*/
- (NSString *)contractKey {
    return [self systemConfig][@"contractKey"];
}


- (NSString *)productName {
    return [self systemConfig][@"productName"];
}

- (NSString *)umengChannel {
    return [self systemConfig][@"umengChannel"];
}

- (NSString *)emgKey {
    return @"BB47201446E9E881";
}

- (NSString *)userName {
    return @"00000000000";
}

- (NSString *)userPwd {
    return @"00000000";
}

- (NSArray *)versionExplain {
    NSArray *arr = self.configDic[@"versionExplain"];
    return arr?arr:[NSArray array];
}

- (NSArray *)guideImagesIphone4 {
    return [self guideImages][@"iphone4"];
}

- (NSArray *)guideImagesIphoneOther {
    return [self guideImages][@"iphoneOther"];
}

- (BOOL)isGuideImagesShowPageControl {
    return [[self guideImages][@"isShowPageControl"] boolValue];
}

- (NSString *)guideImagesCurrentPageIndicatorTintColor {
    return [self guideImages][@"currentPageIndicatorTintColor"];
}

- (NSString *)guideImagesPageIndicatorTintColor {
    return [self guideImages][@"pageIndicatorTintColor"];
}

// 广告页
//code
- (NSString *)advertisementStartCode {
    return [self advertisementCode][@"start"];
}
- (NSString *)advertisementPopCode {
    return [self advertisementCode][@"pop"];
}
- (NSString *)advertisementMarqueeCode {
    return [self advertisementCode][@"marquee"];
}
- (NSString *)advertisementBannerCode {
    return [self advertisementCode][@"banner"];
}

//path
- (NSString *)advertisementStartPath; {
    return [self advertisementPath][@"start"];
}
- (NSString *)advertisementPopPath; {
    return [self advertisementPath][@"pop"];
}
- (NSString *)advertisementMarqueePath;
{
    return [self advertisementPath][@"marquee"];
}
- (NSString *)advertisementBannerPath;
{
    return [self advertisementPath][@"banner"];
}

#pragma mark ---- property methods ----

- (NSDictionary *)configDic {
    if (!_configDic) {
        _configDic = [NSDictionary dictionaryWithContentsOfURL:[[Infrastructure getResManager] configPath]];
    }
    return _configDic;
}

- (NSDictionary *)styleConfigDic {
    if (!_styleConfigDic) {
        _styleConfigDic = [NSDictionary dictionaryWithContentsOfURL:[[Infrastructure getResManager] styleConfigPath]];
    }
    return _styleConfigDic;
}

- (NSDictionary *)serverDic {
    if (!_serverDic) {
        _serverDic = [NSDictionary dictionaryWithContentsOfURL:[[Infrastructure getResManager] serverConfigPath]];
    }
    return _serverDic;
}

- (NSDictionary *)errorCodeDic {
    if (!_errorCodeDic) {
        _errorCodeDic = [NSDictionary dictionaryWithContentsOfURL:[[Infrastructure getResManager] errorCodePath]];
    }
    return _errorCodeDic;
}

#pragma mark ---- private methods ----

- (NSDictionary *)systemConfig {
    return self.configDic[@"systemconfig"];
}

- (NSDictionary *)thirdConfig {
    return [self systemConfig][@"thirdapps"];
}

- (NSDictionary *)styleConfig {
    return self.configDic[@"styleconfig"];
}

- (NSDictionary *)guideImages {
    return self.configDic[@"guideImages"];
}

- (NSDictionary *)advertisementCode {
    return self.configDic[@"promote"][@"advertisementCode"];
}

- (NSDictionary *)advertisementPath {
    return self.configDic[@"promote"][@"advertisementPath"];
}

@end
