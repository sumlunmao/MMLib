//
//  NSString+Kit.h
//  Tickets
//
//  Created by Guanyy on 13-11-5.
//  Copyright (c) 2013年 Guan Yayang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Kit)

+ (BOOL)isEmpty:(NSString*)string;

- (BOOL)isValidEmail;

- (BOOL)isValidMobilePhone;

- (BOOL)isValidPayPassword; //6位数，不重复，不连续

- (BOOL)isValidLoginPassword;

- (BOOL)isValidIDCard;

- (BOOL)isValidBankCard;

- (NSString*)MD5;

- (NSString*)trimmingSpecialCharacters; //排除特殊字符

- (int)indexOf:(NSString *)text;

- (BOOL)bankCardValidate;

- (BOOL)idCardNumberValidate;

- (NSString *)normalNumToBankNum;

- (NSString *)bankNumToNormalNum;

- (NSURL *)imageUrl;

- (NSString *)standardDate;

+ (BOOL)checkPureNum:(NSString *)str;

+ (BOOL)checkNum:(NSString *)str;  // 只有两位小数的数字

- (BOOL)myContainsString:(NSString*)other;   // 兼容IOS7 ：IOS7中没有containsString 方法

-  (int)mixedLength;

- (NSString *)timestamp;   // 时间戳

- (BOOL)isChineseAndPoint; //判断包含中文和点

- (BOOL)isChinese;//判断是否是纯汉字

- (BOOL)includeChinese;//判断是否含有汉字

+ (NSString *)UUID;

//- (NSString *)UTF8Str;

//- (NSString *)stringFromUTF8;

#pragma mark ---- mo9methods ----

- (NSString *)portrait;

- (NSString *)topicThumbnail;

- (NSString *)convertHttpToHttps;

@end
