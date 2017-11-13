//
//  Mo9StandardResp.m
//  Mo9Client
//
//  Created by ChenJian on 2017/3/13.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "Mo9HttpResp.h"
#import <AFNetworking/AFNetworking.h>

@implementation Mo9HttpResp

- (NSString*)description {
    if (![self hasError]) {
        if (self.dic) {
            return [NSString stringWithFormat:@"%@",self.dic];
        }
        if (self.array) {
            return [NSString stringWithFormat:@"%@",self.array];
        }
        return nil;
    }else
        return [NSString stringWithFormat:@"code:%zd",self.code];
}

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        _code = [dict[@"code"] integerValue];
        
        _message = dict[@"message"];
        if ([_message isKindOfClass:[NSString class]]) {
            _message = [_message stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }else {
            _message = @"";
        }
        Log(@"message:%@",_message);
        
        if ([dict.allKeys containsObject:@"timestamp"]) {
            _timestamp = [dict[@"timestamp"] doubleValue];
            double deviceTimestamp = [[NSDate date] timeIntervalSince1970];
            [Infrastructure getCommonManager].timestampDelta = _timestamp*0.001 - deviceTimestamp;
            Log(@"serverTimestamp:%f",_timestamp);
            Log(@"deviceTimestamp:%f",deviceTimestamp);
            Log(@"timestampDelta:%f",[Infrastructure getCommonManager].timestampDelta);
        }
        
        if (_code == 0) {
            _data = [dict objectForKey:@"data"];
            if ([_data isKindOfClass:[NSDictionary class]]) {
                NSDictionary *resultDic = [_data objectForKey:@"entity"];
                if (resultDic) {
                    _dic = resultDic;
                }else {
                    _dic = @{};
                }
                NSArray *arr = [self.data objectForKey:@"entities"];
                if (arr) {
                    _array = arr;
                }else {
                    _array = @[];
                }
            }else {
                [self resetDatas];
            }

        }else {
            [self resetDatas];
        }
           }
    return self;
}

- (id)initWithError:(NSError *)error {
    self = [super init];
    if(self) {
        NSHTTPURLResponse *respone = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        if (respone) {
            _code = respone.statusCode;
        }else {
            _code = error.code;
        }
        _message = [self errorMessage];
        [self resetDatas];
    }
    return self;
}

- (void)resetDatas {
    _data = @{};
    _dic = @{};
    _array = @[];
}

- (BOOL)hasError {
    if (self.code != 0) {
        return YES;
    } else
        return NO;
}



- (NSString *)errorMessage {
    NSString *err = [[Infrastructure getConfigManager] errorCodeDic][[NSString stringWithFormat:@"%@",@(_code)]];
    if (err) {
        return err;
    } else {
        return Error_Mo9RequestFail;
    }
}


@end
