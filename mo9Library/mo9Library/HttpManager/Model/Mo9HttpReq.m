//
//  Mo9HttpReq.m
//  Mo9Mokredit
//
//  Created by Guanyy on 14/9/9.
//  Copyright (c) 2014年 Mo9. All rights reserved.
//

#import "Mo9HttpReq.h"
@interface Mo9HttpReq()

@end

@implementation Mo9HttpReq
@synthesize timestamp = _timestamp;

- (instancetype)initWithApi:(Api)api {
     return [self initWithApi:api params:@{}];
}

- (instancetype)initWithApi:(Api)api params:(NSDictionary *)params{
    self = [super init];
    if (self) {
        self.api = api;
        self.params = [NSMutableDictionary dictionaryWithDictionary:params?:@{}];
        self.methodType = HttpMethodTypePost;
    }
    return self;
}

- (void)addParam:(NSString *)value forKey:(NSString *)key {
    if(value == nil || key == nil)
        return;
    if(self.params == nil)
        self.params = [NSMutableDictionary new];
    [self.params setObject:value forKey:key];
}

- (NSString *)sign
{
    return [Infrastructure getUserDefaultUtils].accessToken.length>0 ? [self securitySign] : [self normalSign];
}

- (NSString *)normalSign
{
    NSString *timestamp = _timestamp;
    if (timestamp.length==0) {
        return @"";
    }
    NSInteger endNum = [[timestamp substringFromIndex:timestamp.length-1] integerValue];
    NSString *signTimeStamp = @"";
    if (endNum%2 == 0) {
        signTimeStamp = [timestamp substringToIndex:10];
    }else {
        signTimeStamp = [timestamp substringFromIndex:timestamp.length-10];
    }
    NSString *content = [self content];
    
    NSString *params = [NSString stringWithFormat:@"%@%@%@",content,signTimeStamp,[[Infrastructure getConfigManager] securityKey]];
    NSString *signedParams = [params MD5];
    Log(@"httpParams:%@,sign:%@",params,signedParams);
    return signedParams;
}

- (NSString *)securitySign
{
    NSString *timestamp = _timestamp;
    if (timestamp.length==0) {
        return @"";
    }
    NSInteger endNum = [[timestamp substringFromIndex:timestamp.length-1] integerValue];
    NSString *signTimeStamp = @"";
    if (endNum%2 == 0) {
        signTimeStamp = [timestamp substringToIndex:10];
    }else {
        signTimeStamp = [timestamp substringFromIndex:timestamp.length-10];
    }
    NSString *jsonStr = @"";
    if (self.params.count>0) {
        jsonStr = [self content];
    }
    NSString *params = [NSString stringWithFormat:@"%@%@%@%@",jsonStr,signTimeStamp,[[Infrastructure getConfigManager] securityKey], [Infrastructure getUserDefaultUtils].accessToken];
    NSString *signedParams = [params MD5];
    Log(@"httpParams:%@,sign:%@",params,signedParams);
    return signedParams;
}

- (NSString *)timestamp {
    NSTimeInterval times = [[NSDate date] timeIntervalSince1970];
    _timestamp = [NSString stringWithFormat:@"%.0f", times*1000];
    Log(@"httpTimestamp:%@",_timestamp);
    return _timestamp;
}

- (NSString *)content
{
    NSString *content = @"";
    if (self.params.count>0) {
        if ([self.methodType isEqualToString:kHttpMethodPost]) {
            content = [CommonFunction jsonStringWithoutSpaceWithObject:self.params];
        } else {
            content = [CommonFunction convertStringWithDic:self.params];
        }
    }
    Log(@"httpContent:%@",content);
    return content;
}


@end
