//
//  ConfigManager+Style.m
//  Mo9Client
//
//  Created by ChenJian on 2017/5/12.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "ConfigManager+Style.h"
#import "UIColor+Kit.h"

NSString *const FONTSIZE_XXXL = @"xxxl";
NSString *const FONTSIZE_XL = @"xl";
NSString *const FONTSIZE_L = @"l";
NSString *const FONTSIZE_M = @"m";
NSString *const FONTSIZE_S = @"s";
NSString *const FONTSIZE_XS = @"xx";
NSString *const FONTSIZE_XXS = @"xxs";
NSString *const FONTSIZE_XXXS = @"xxxs";


@implementation ConfigManager (Style)


- (UIFont *)fontWithKey:(NSString *)key {
    if (key.length == 0) {
        Log(@"Font Error: font can't be blank");
        return nil;
    }
    NSArray *fontArr = [[key lowercaseString] componentsSeparatedByString:@"_"];
    UIFont *font;
    if (fontArr.count >= 2) {
        NSNumber *fontsize;
        NSString *fontname;
        fontsize = [[self fontSizeDic] objectForKey:[NSString stringWithFormat:@"%@_%@",fontArr[0],fontArr[1]]];
        if (fontArr.count>2) {
            fontname = [[self fontNameDic] objectForKey:fontArr[2]];
        }
        if (fontsize) {
            if (fontname&&![fontname isEqualToString:@"system"]) {
                font = [UIFont fontWithName:fontname size:fontsize.floatValue];
            }else {
                font = [UIFont systemFontOfSize:fontsize.floatValue];
            }
        }else {
            Log(@"Font Error: can't found fontsize for key %@",key);
        }
    }else {
        Log(@"Font Error: font format is error for key %@.\n example:\"fonsize_XL_1\"",key);
    }
    return font;
}

- (UIFont *)fontWithSize:(NSString *)size name:(aFontNameCode)nameCode{
    if (size) {
        NSString *key = [NSString stringWithFormat:@"fontsize_%@_%zd",size,nameCode];
        UIFont *font = [self fontWithKey:key];
        return font;
    }else
        return nil;
}


#pragma mark --- color ----

- (UIColor *)colorWithKey:(NSString *)key {
    return [UIColor colorWithHex:[self colorHexWithKey:key]];
}

- (NSString*)colorHexWithKey:(NSString *)key {
    return [[self colorDic][[key lowercaseString]] substringToIndex:6];//取前6位值
}

//black
- (UIColor*)color_black_a {
    return [self colorWithKey:@"color_black_a"];
}

//gray
- (UIColor*)color_gray_a {
    return [self colorWithKey:@"color_gray_a"];
}

- (UIColor*)color_gray_b {
    return [self colorWithKey:@"color_gray_b"];
}

- (UIColor*)color_gray_c {
    return [self colorWithKey:@"color_gray_c"];
}

- (UIColor*)color_gray_d {
    return [self colorWithKey:@"color_gray_d"];
}

- (UIColor*)color_gray_e {
    return [self colorWithKey:@"color_gray_e"];
}

//blue
- (UIColor*)color_blue_a {
    return [self colorWithKey:@"color_blue_a"];
}

- (UIColor*)color_blue_b {
    return [self colorWithKey:@"color_blue_b"];
}

- (UIColor*)color_blue_c {
    return [self colorWithKey:@"color_blue_c"];
}

- (UIColor*)color_blue_d {
    return [self colorWithKey:@"color_blue_d"];
}

- (UIColor*)color_blue_e {
    return [self colorWithKey:@"color_blue_e"];
}

//white
- (UIColor*)color_white_a {
    return [self colorWithKey:@"color_white_a"];
}

//pink
- (UIColor*)color_pink_a {
    return [self colorWithKey:@"color_pink_a"];
}

//dark
- (UIColor*)color_drak_a {
    return [self colorWithKey:@"color_drak_a"];
}

- (UIColor*)color_drak_b {
    return [self colorWithKey:@"color_drak_b"];
}

- (UIColor*)color_drak_c {
    return [self colorWithKey:@"color_drak_c"];
}

- (UIColor*)color_drak_d {
    return [self colorWithKey:@"color_drak_d"];
}

- (UIColor *)color_drak_e {
    return [self colorWithKey:@"color_drak_e"];
}

//yellow
- (UIColor *)color_yellow_a {
    return [self colorWithKey:@"color_yellow_a"];
}

//private methods
- (NSDictionary *)colorDic {
    return [self styleConfigDic][@"collect"][@"color"];
}

- (NSDictionary *)fontNameDic {
    return [self styleConfigDic][@"collect"][@"fontname"];
}

- (NSDictionary *)fontSizeDic {
    return [self styleConfigDic][@"collect"][@"fontsize"];
}





@end
