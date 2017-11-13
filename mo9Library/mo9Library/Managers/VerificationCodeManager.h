//
//  VerificationCodeManager.h
//  Mo9Client
//
//  Created by administrator on 2017/5/16.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "BaseManager.h"
#define kVerifyCodeTime @"codeTime"
typedef enum {
    VerificationCodeLogin, // 登录
    VerificationCodeRegister // 注册
} VerificationCodeType;

typedef enum {
    VerificationCodeResendIntervalLogin = 60,
    VerificationCodeResendIntervalRegister = 45
}VerificationCodeResendIntervalType;

@interface VerificationCodeManager : BaseManager
-(void)setTimeForCodeType:(VerificationCodeType)codeType withDic:(NSDictionary *)dic;
-(NSDictionary *)dictionaryWithIntervalType:(VerificationCodeResendIntervalType)intervalType CodeType:(VerificationCodeType)codeType ;
@end
