//
//  StandardTextField.m
//  Mo9Client
//
//  Created by ChenJian on 16/11/7.
//  Copyright © 2016年 mo9. All rights reserved.
//

#import "StandardTextField.h"

@interface StandardTextField()<UITextFieldDelegate>

@end

@implementation StandardTextField
@synthesize standardText = _standardText;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:self];
}

- (void)textChanged:(NSNotification *)notification {
    UITextField *textfield = notification.object;
    self.standardText = textfield.text;
}

- (void)setStandardText:(NSString *)standardText {
    _standardText = standardText;
    if (_type == FieldTypePhoneNum) {
        NSMutableString *mStr = [NSMutableString stringWithString:[self standardText]];
        if (mStr.length>3) {
            [mStr insertString:@" " atIndex:3];
        }
        if (mStr.length>8) {
            [mStr insertString:@" " atIndex:8];
        }
        self.text = mStr;
    }else if (_type == FieldTypeCardId) {
        NSMutableString *mStr = [NSMutableString stringWithString:[self standardText]];
        if (mStr.length>6) {
            [mStr insertString:@" " atIndex:6];
        }
        if (mStr.length>11) {
            [mStr insertString:@" " atIndex:11];
        }
        if (mStr.length>16) {
            [mStr insertString:@" " atIndex:16];
        }
        self.text = mStr;
    }else
        self.text = standardText;
}

- (NSString *)standardText {
    if (_type != FieldTypeDefault) {
        _standardText = [_standardText stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    return _standardText;
}

@end
