//
//  ConfigManager+Theme.h
//  Mo9Client
//
//  Created by ChenJian on 2017/5/23.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "ConfigManager.h"

@interface ConfigManager (Theme)

#pragma mark ---- plist config ----

- (UIColor *)mainBgColor;

//bg color
- (UIColor *)navbarBgColor;

- (UIColor *)tabbarBgColor;

//title color
- (UIColor *)navbarTitleColor;

- (UIColor *)tabbarTitleColor;

- (UIColor *)tabbarSelectedTitleColor;

- (UIColor *)placeholderColor;

- (UIColor *)mainTextColor;


- (NSString *)launchGifNamePath;



@end
