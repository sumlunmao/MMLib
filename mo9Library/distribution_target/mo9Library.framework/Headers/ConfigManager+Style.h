//
//  ConfigManager+Style.h
//  Mo9Client
//
//  Created by ChenJian on 2017/5/12.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "ConfigManager.h"

typedef enum {
    FontNameCodeSystem = 0,
    FontNameCodePingFangSC = 1,
}aFontNameCode;

extern NSString *const FONTSIZE_XXXL;
extern NSString *const FONTSIZE_XL;
extern NSString *const FONTSIZE_L;
extern NSString *const FONTSIZE_M;
extern NSString *const FONTSIZE_S;
extern NSString *const FONTSIZE_XS;
extern NSString *const FONTSIZE_XXS;
extern NSString *const FONTSIZE_XXXS;

@interface ConfigManager (Style)




//key 格式：fontsize_fontSizeCode_fontNameCode example:fontsize_xl_1
- (UIFont*)fontWithKey:(NSString *)key;

- (UIFont*)fontWithSize:(NSString *)size name:(aFontNameCode)nameCode;




- (UIColor*)colorWithKey:(NSString *)key;

- (NSString*)colorHexWithKey:(NSString *)key;

#pragma mark --- black ---
//424242
- (UIColor*)color_black_a;

#pragma mark --- gray ---
//717171    
- (UIColor*)color_gray_a;

//999999    light
- (UIColor*)color_gray_b;

//AAAAAA     image
- (UIColor*)color_gray_c;

//C9C9CF    placeholder
- (UIColor*)color_gray_d;

//F6F7F7  background
- (UIColor*)color_gray_e;

#pragma mark --- blue ---

//5E86D9
- (UIColor*)color_blue_a;

//77A8EF  xyqb nav blue
- (UIColor*)color_blue_b;

//58618E  xyqb text blue
- (UIColor*)color_blue_c;

//284576  fsd blue
- (UIColor*)color_blue_d;

//4F81D9  fsd blue placeholder
- (UIColor*)color_blue_e;

#pragma mark --- white ---

- (UIColor*)color_white_a;


#pragma mark --- pink ---

- (UIColor*)color_pink_a;

#pragma mark --- drak ---
// 08A7C5 xgd tabbarbgcolor
- (UIColor*)color_drak_a;
// ACF3E6 xgd tabbarselectedtitlecolor
- (UIColor*)color_drak_b;
// 0AA8C5 xgd navbartitlecolor
- (UIColor*)color_drak_c;
// 003E49 xgd tabbartitlecolor
- (UIColor*)color_drak_d;
// 07A7C4 xgd drak green placeholder
- (UIColor*)color_drak_e;

#pragma mark --- yellow ---
// F6BE4D xgd text yellow
- (UIColor*)color_yellow_a;

@end
