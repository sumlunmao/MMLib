//
//  UITextField+Kit.h
//  Mo9V2
//
//  Created by Guanyy on 13-12-16.
//  Copyright (c) 2013年 moKredit Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Kit)

- (void)addLeftPadding:(int)padding;

- (void)addNumberPadInputAccessoryView;

+ (BOOL)textFieldBankCardFormat:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
+ (BOOL)textFieldLimitLength:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string maxLength:(NSUInteger)maxLength;

@end
