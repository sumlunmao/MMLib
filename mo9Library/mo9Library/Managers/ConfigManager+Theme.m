//
//  ConfigManager+Theme.m
//  Mo9Client
//
//  Created by ChenJian on 2017/5/23.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "ConfigManager+Theme.h"
#import "UIImage+Kit.h"

@implementation ConfigManager (Theme)

#pragma mark ---- plist config ----

#pragma mark ---- bg color ----

- (UIColor *)navbarBgColor {
    return [self colorWithKey:[self bgColorConfig][@"navbarbgcolor"]];
}

- (UIColor *)tabbarBgColor {
    return [self colorWithKey:[self bgColorConfig][@"tabbarbgcolor"]];
}

- (UIColor *)mainBgColor {
    return [self colorWithKey:[self bgColorConfig][@"mainBgColor"]];
}

#pragma mark ---- title color ----

- (UIColor *)navbarTitleColor {
    return [self colorWithKey:[self titleColorConfig][@"navbartitlecolor"]];
}

- (UIColor *)tabbarTitleColor {
    return [self colorWithKey:[self titleColorConfig][@"tabbartitlecolor"]];
}

- (UIColor *)tabbarSelectedTitleColor {
    return [self colorWithKey:[self titleColorConfig][@"tabbarselectedtitlecolor"]];
}




- (NSString *)launchGifNamePath {
    NSString *name = @"";
    if (IS_IPHONE_4) {
        name = [self imageConfig][@"launchgif"][@"launchimagefor4"];
    }else {
        name = [self imageConfig][@"launchgif"][@"launchimagefor6"];
    }
    if (name.length>0) {
        name = [[NSBundle bundleWithPath:[[Infrastructure getResManager] resBundlePath]] pathForResource:name ofType:nil];
    }
    return name;
}

#pragma mark ---- targets config ----


- (UIColor *)mainTextColor {
    return [self colorWithKey:[self titleColorConfig][@"mainTextColor"]];
}

- (UIColor *)placeholderColor {
    return [self colorWithKey:[self titleColorConfig][@"placeholderColor"]];
}

#pragma mark ---- private methods ----

- (NSDictionary *)titleColorConfig {
    return [self styleconfig][@"colorconfig"][@"titlecolorconfig"];
}

- (NSDictionary *)bgColorConfig {
    return [self styleconfig][@"colorconfig"][@"bgcolorconfig"];
}

- (NSDictionary *)imageConfig {
    return [self styleconfig][@"imageconfig"];
}

- (NSDictionary *)styleconfig {
    return self.styleConfigDic[@"styleconfig"];
}

@end
