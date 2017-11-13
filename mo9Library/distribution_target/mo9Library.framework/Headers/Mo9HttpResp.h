//
//  Mo9StandardResp.h
//  Mo9Client
//
//  Created by ChenJian on 2017/3/13.
//  Copyright © 2017年 mo9. All rights reserved.
//


@interface Mo9HttpResp : NSObject

//服务返回
@property (nonatomic, assign, readonly) NSInteger code;
@property (nonatomic, strong, readonly) NSDictionary *data;
@property (nonatomic, copy, readonly)   NSString *message;
@property (nonatomic, assign, readonly) double timestamp;



@property (nonatomic, strong, readonly) NSDictionary *dic; //从data中获取
@property (nonatomic, strong, readonly) NSArray *array;    //从data中获取

- (id)initWithDictionary:(NSDictionary *)dict;
- (id)initWithError:(NSError *)error;

- (BOOL)hasError;
- (NSString *)errorMessage;

@end
