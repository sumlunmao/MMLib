//
//  NSString+Kit.m
//  Tickets
//
//  Created by Guanyy on 13-11-5.
//  Copyright (c) 2013年 Guan Yayang. All rights reserved.
//

#import "NSString+Kit.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Kit)

+ (BOOL)isEmpty:(NSString*)string {
    if([string isEqual:[NSNull null]] || string == nil || [string length] == 0 || [string caseInsensitiveCompare:@"null"] == NSOrderedSame || [string caseInsensitiveCompare:@"nil"] == NSOrderedSame || [string caseInsensitiveCompare:@"<null>"] == NSOrderedSame) {
        return YES;
    }
    return NO;
}

- (BOOL)isValidEmail;
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidMobilePhone {
    if([self length] != 11) {
        return NO;
    }else {
        return YES;
    }
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,183
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|7[0])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,183
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,181,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[156])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189
//     22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    
//    if (([regextestmobile evaluateWithObject:self] == YES) || ([regextestcm evaluateWithObject:self] == YES) || ([regextestct evaluateWithObject:self] == YES)
//        || ([regextestcu evaluateWithObject:self] == YES)) {
//        return YES;
//    }
//    else {
//        return NO;
//    }
}

- (NSString*)MD5 {
    // Create pointer to the string as UTF8
    const char *ptr = [self UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

- (NSString*)trimmingSpecialCharacters {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    return [self stringByTrimmingCharactersInSet:set];
}

- (int)indexOf:(NSString *)text {
    NSRange range = [self rangeOfString:text];
    if (range.location != NSNotFound) {
        return (int)range.location;
    }
    else {
        return -1;
    }
}

- (BOOL)bankCardValidate {
    if([NSString isEmpty:self])
        return NO;
    else {
        char bit = [self bankCardCheckCode:[self substringToIndex:self.length - 1]];
        if(bit == 'N')
            return NO;
        char c = [self characterAtIndex:self.length - 1];
        return c == bit;
    }
}

- (char)bankCardCheckCode:(NSString*)nonCheckCodeCardId {
    if(nonCheckCodeCardId == nil || [nonCheckCodeCardId stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0)
        return 'N';
    
    NSString *phoneRegex = @"\\d+";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    if(![phoneTest evaluateWithObject:nonCheckCodeCardId])
        return 'N';
    
    const char *chs = [nonCheckCodeCardId UTF8String];
    int luhmSum = 0;
    for(int i = (int)strlen(chs) - 1, j = 0; i >= 0; i--, j++) {
        int k = chs[i] - '0';
        if(j % 2 == 0) {
            k *= 2;
            k = k / 10 + k % 10;
        }
        luhmSum += k;
    }
    
    return (luhmSum % 10 == 0) ? '0' : (char)((10 - luhmSum % 10) + '0');
}

- (BOOL)idCardNumberValidate {
    
    NSString* value = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length = 0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        
        if (length != 15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];

            
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value  substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

// 正常号转银行卡号 － 增加4位间的空格
- (NSString *)normalNumToBankNum {
    NSString *tmpStr = [self bankNumToNormalNum];
    
    int size = (int)(tmpStr.length / 4);
    
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++)
    {
        [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    
    [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(size*4, (tmpStr.length % 4))]];
    
    tmpStr = [tmpStrArr componentsJoinedByString:@" "];
    
    return tmpStr;
}

// 银行卡号转正常号 － 去除4位间的空格
- (NSString *)bankNumToNormalNum {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSURL *)imageUrl {
    return [NSURL URLWithString:self];
}

- (NSString *)standardDate {
    NSRange rang = [self rangeOfString:@" "];
    return [self substringToIndex:rang.location];
}

#define myDotNumbers     @"0123456789.\n"
#define myNumbers          @"0123456789\n"

+ (BOOL)checkPureNum:(NSString *)str {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
    NSString *filtered = [[str componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [str isEqualToString:filtered];
    return basicTest;
}

// 检测输入金额 数字或两位小数
+ (BOOL)checkNum:(NSString *)str
{
        NSString *regex = @"^(([1-9]+)|([0-9]+.[0-9]{1,2}))";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:str];

        if (!isMatch ) {
            return NO;
        }

    return YES;
}
- (BOOL)isValidPayPassword {
    // 密码为6位数字 不连续 不重复
    NSString *regex = @"^[0-9]{6}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    int up = 0;
    int down = 0;
    int equal = 0;
    for (int i = 1; i < self.length; i ++) {
        int  this = [[self substringWithRange:NSMakeRange(i, 1)] intValue];
        int  last = [[self substringWithRange:NSMakeRange(i-1, 1)] intValue];
        if ((this - last) == 1) {
            up ++;
        } else if((last - this) == 1) {
            down ++;
        } else if ((last - this) == 0) {
            equal ++;
        }
    }
    if (up == 5 || down == 5 || equal == 5) {
        return NO;
    }
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidLoginPassword {
    if (self.length<8) {
        return NO;
    }else
        return YES;
}

-(BOOL)isValidIDCard {
    NSString *value;
    value = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }else
        return YES;
    
//    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
//    NSString *leapMmdd = @"0229";
//    NSString *year = @"(19|20)[0-9]{2}";
//    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
//    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
//    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
//    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
//    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
//    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
//    
//    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    if (![regexTest evaluateWithObject:value]) {
//        return NO;
//    }
//    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
//    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
//    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
//    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
//    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
//    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
//    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
//    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
//    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
//    NSInteger remainder = summary % 11;
//    NSString *checkBit = @"";
//    NSString *checkString = @"10X98765432";
//    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
//    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

- (BOOL)isValidBankCard {
    if (self.length < 16 || self.length > 19) {
        return NO;
    }else
        return YES;
}

- (BOOL)myContainsString:(NSString*)other {
    NSRange range = [self rangeOfString:other];
    return range.length != 0;
}


-  (int)mixedLength {
    if (!self) {
        return 0;
    }
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

- (NSString *)timestamp {
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    
    // 设置日期格式
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

- (BOOL)isChineseAndPoint
{
    NSString *match = @"^([\u4e00-\u9fa5\\.\\·]*)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)includeChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

+ (NSString *)UUID {
    NSString *uuid = [NSUUID UUID].UUIDString;
    return uuid;
}

- (NSString *)UTF8Str {
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)stringFromUTF8 {
   return  [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)portrait {
    return [self imageUrlHeight:200];
}

- (NSString *)topicThumbnail {
    return [self imageUrlHeight:300];
}

- (NSString *)imageUrlHeight:(NSInteger)height {
    NSString *linkWord = @"&";
    NSRange rang = [self rangeOfString:@"?"];
    if (rang.location == NSNotFound||rang.length==0) {
        linkWord = @"?";
    }
    NSString *str = [[NSString stringWithFormat:@"%@%@x-oss-process=image/resize,h_%zd",self,linkWord,height] convertHttpToHttps];
    return str;
}

- (NSString *)convertHttpToHttps {
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",self];
    
    return [str stringByReplacingOccurrencesOfString:@"http:" withString:@"https:"];
}

@end
