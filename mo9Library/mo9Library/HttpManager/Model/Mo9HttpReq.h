//
//  Mo9HttpReq.h
//  Mo9Mokredit
//
//  Created by Guanyy on 14/9/9.
//  Copyright (c) 2014年 Mo9. All rights reserved.
//
#import <Foundation/Foundation.h>

#define HttpMethodTypePost  @"POST"
#define HttpMethodTypeGet   @"GET"

typedef NSString* Api;
typedef NSString* HTTPMethodType;

@interface Mo9HttpReq : NSObject

/**
 *  Api地址，实际应为Base URL对应的接口名
 */
@property (nonatomic,copy) Api api;
/**
 *  请求方式，默认是POST
 */
@property (nonatomic,copy) HTTPMethodType methodType;

/**
 *  需传递的参数
 */
@property (nonatomic, strong) NSMutableDictionary *params;


//超时时间
@property (nonatomic,strong) NSNumber *timeoutSeconds;


/*
 先取timestamp,再获取signedParams。
 每次get都会获取当前最新的timestamp
 */
@property (nonatomic,copy, readonly) NSString *timestamp;

- (NSString *)sign; // 根据accessToken状态获取normalSign或securitySign

- (NSString *)normalSign;

- (NSString *)securitySign;

/*
 */

/**
 *  初始化Req
 *
 *  @param api 对应的Api
 *
 *  @return HTTPReq
 */
- (instancetype)initWithApi:(Api)api;


/**
 *  初始化Req
 *
 *  @param api    对应的Api
 *  @param params 所传参数
 *
 *  @return HTTPReq
 */
- (instancetype)initWithApi:(Api)api params:(NSDictionary *)params;


/**
 *  在已有的参数中添加参数(此函数为避免参数为nil的情况)
 *
 *  @param value value
 *  @param key   key
 */
- (void)addParam:(NSString*)value forKey:(NSString*)key;

@end
