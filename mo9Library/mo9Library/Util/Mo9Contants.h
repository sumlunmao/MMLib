//
//  Mo9Contants.h
//  mo9Library
//
//  Created by ChenJian on 2017/7/20.
//  Copyright © 2017年 mo9. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EnvironState) {
    EnvironStateDev,
    EnvironStateClone,
    EnvironStatePre,
    EnvironStateProduct,
};

typedef NS_ENUM(NSUInteger, AppType) {
    AppTypeQJJ = 1,
    AppTypeLBT = 2,
};

typedef NS_ENUM(NSInteger, ServerType) {
    ServerTypeLBT,
    ServerTypeQJJ,
    ServerTypeAccount,
    ServerTypePromote,
};

#define Log(format, ...) [[Infrastructure getLibraryManager] isDebug]==NO?:NSLog(format, ## __VA_ARGS__)

#define SYSTEM_VERSION() [[UIDevice currentDevice].systemVersion  floatValue]


#define IS_IPHONE_6Plus ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )

#define IS_IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



#define MobiExchangeRate 100.0

#define kPageSize 10
#define kPageStart 0


/**
 *  constants
 */
#define kPhoneLength 11
#define kPassword_MinLength 8
#define kPassword_MaxLength 18

#define kPayPassword_MinLength 8
#define kPayPassword_MaxLength 12

#define kZipCode_Length 6


#define kPin_Length 6

#define kUITextFieldLeftPadding     5
#define kUITextField_MaxLength 64

#define kWinSize [UIScreen mainScreen].bounds.size

/*
 网络常量
 */
#define kTimeoutInterval 30
#define kHttpMethodPost @"POST"
#define kHTTPMethodGet @"GET"


#define kWinSize [UIScreen mainScreen].bounds.size

#define kKey_ErrorMsg @"errorMsg"

#define Error_Mo9RequestFail @"服务器开了个小差，请再试一次"
#define Error_Mo9_CameraNotSupported @"该设备不支持相册"
#define Error_Mo9_LoadFailed @"加载失败，请重试"
