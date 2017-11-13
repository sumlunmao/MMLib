
//
//  UITextField+Kit.m
//  Mo9V2
//
//  Created by Guanyy on 13-12-16.
//  Copyright (c) 2013年 moKredit Inc. All rights reserved.
//

#import "UITextField+Kit.h"

@implementation UITextField (Kit)

- (void)addLeftPadding:(int)padding {
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, padding, 20)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}


- (void)addNumberPadInputAccessoryView {
    UIToolbar* numberToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           //[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:nil action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    self.inputAccessoryView = numberToolbar;
}

- (void)doneWithNumberPad {
    [self endEditing:YES];
}


+ (BOOL)textFieldBankCardFormat:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    if (newString.length >= 24) {
        return NO;
    }
    
    [textField setText:newString];
    
    return NO;
}

+ (BOOL)textFieldLimitLength:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string maxLength:(NSUInteger)maxLength {
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= maxLength || returnKey;
    
}


@end
