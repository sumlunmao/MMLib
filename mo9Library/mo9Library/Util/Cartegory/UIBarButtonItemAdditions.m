//
//  UIBarButtonItemAdditions.m
//  CityGuide
//
//  Created by COLD FRONT on 12-6-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIBarButtonItemAdditions.h"
#import "UIButton+Kit.h"

@implementation UIBarButtonItem(Additions)

+ (UIBarButtonItem *)backBarButtonItemWithTarget:(id)target selector:(SEL)selector {
    return [self barButtonItemWithTitle:@""
                                  image:[UIImage imageNamed:@"btn_back"]
                         highlightImage:[UIImage imageNamed:@"btn_back"]
                                 target:target
                               selector:selector];
}

+ (UIBarButtonItem *)rectBarButtonItemWithTitle:(NSString *)title
                                         target:(id)target
                                       selector:(SEL)selector {
    return [self barButtonItemWithTitle:title
                                  image:nil
                         highlightImage:nil
                                 target:target
                               selector:selector];
}


+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image
                                     target:(id)target
                                   selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title
                                      image:(UIImage *)image
                             highlightImage:(UIImage *)highlightImage
                                     target:(id)target 
                                   selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:btnTitleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    CGSize imageSize = image.size;
    CGFloat margin = (button.frame.size.width - imageSize.width)*0.5;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -margin, 0, margin);
//    [button sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title
                                      image:(UIImage *)image
                               disableImage:(UIImage *)disableImage
                                     target:(id)target
                                   selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:btnTitleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    button.titleLabel.shadowOffset = CGSizeMake(0, -0.2);
    button.titleLabel.shadowColor = [[UIColor alloc] initWithWhite:0 alpha:0.2f];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:disableImage forState:UIControlStateDisabled];
    [button sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIButton *)ButtonItemWithTitle:(NSString *)title
                            image:(UIImage *)image
                     disableImage:(UIImage *)disableImage
                           target:(id)target
                         selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:btnTitleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    button.titleLabel.shadowOffset = CGSizeMake(0, -0.2);
    button.titleLabel.shadowColor = [[UIColor alloc] initWithWhite:0 alpha:0.2f];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:disableImage forState:UIControlStateDisabled];
    [button sizeToFit];
    return button;
}



@end
