//
//  VerificationCodeManager.m
//  Mo9Client
//
//  Created by administrator on 2017/5/16.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "VerificationCodeManager.h"

@interface VerificationCodeManager ()

@property (nonatomic,strong) NSMutableDictionary *dic;  // 存放不同type对应的时间

@end
@implementation VerificationCodeManager
+(VerificationCodeManager *)manager {
    static VerificationCodeManager *__manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[VerificationCodeManager alloc] init];
    });
    return __manager;
}

-(void)setTimeForCodeType:(VerificationCodeType)codeType withDic:(NSDictionary *)dic {
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:dic];

    if ([dic[kVerifyCodeTime] integerValue] == 0) {
        [d setObject:@(0) forKey:kVerifyCodeTime];
        [self.dic setObject:d forKey:@(codeType)];
        return;
    }
    double time = [[NSDate date] timeIntervalSince1970] + [dic[kVerifyCodeTime] integerValue];
    [d setObject:@(time) forKey:kVerifyCodeTime];
    [self.dic setObject:d forKey:@(codeType)];
}
-(NSDictionary *)dictionaryWithIntervalType:(VerificationCodeResendIntervalType)intervalType CodeType:(VerificationCodeType)codeType {
    if (!self.dic[@(codeType)]) {
        return nil;
    }
   return [self dictionaryWithDic:self.dic[@(codeType)] intervalType:intervalType];
}
-(NSDictionary *)dictionaryWithDic:(NSDictionary *)dic intervalType:(VerificationCodeResendIntervalType)type {
    NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
    double interval = [dic[kVerifyCodeTime] doubleValue]  - nowInterval;
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (interval <= 0) {
        [d setObject:@(0) forKey:kVerifyCodeTime];
        return d;
    }
    if (interval < type ) {
        [d setObject:@(interval) forKey:kVerifyCodeTime];
        return d;
    }
    return dic;
}
-(NSMutableDictionary *)dic {
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}
@end
