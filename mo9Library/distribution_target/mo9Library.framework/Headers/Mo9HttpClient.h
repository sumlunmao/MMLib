//
//  Mo9StandardHttpClient.h
//  Mo9Client
//
//  Created by ChenJian on 2017/3/13.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mo9HttpReq.h"
#import "Mo9HttpResp.h"

typedef void (^HttpStartBlock)(Mo9HttpReq* _Nullable req);
typedef void (^HttpCompletionBlock)(Mo9HttpReq* _Nullable req, Mo9HttpResp* _Nullable resp);
typedef void (^HttpProgressBlock) (NSProgress * _Nullable progress);
typedef void (^HttpFormDataBlock) (id _Nullable formData);

typedef NSDictionary* _Nullable (^ServerConfigBlock) (void);

@interface Mo9HttpClient : NSObject

//在Server.plist中设置defaultType，index从0开始。

+ (Mo9HttpClient *_Nonnull)defaultHttpClient;

+ (Mo9HttpClient *_Nonnull)defaultHttpClientWithConfig:(ServerConfigBlock _Nullable )block;

+ (Mo9HttpClient *_Nonnull)httpClientWithServerType:(ServerType)type;

+ (Mo9HttpClient *_Nonnull)httpClientWithServerType:(ServerType)type configBlock:(ServerConfigBlock _Nullable )block;

+ (Mo9HttpClient *_Nonnull)httpClientWithBaseUrl:(NSString *_Nullable)baseUrl configBlock:(ServerConfigBlock _Nullable )block;
    
- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(nonnull NSString *)field;

- (NSURLSessionDataTask *_Nullable)doHTTPPost:(Mo9HttpReq *_Nullable)req
                               start:(HttpStartBlock _Nullable )startBlock
                          completion:(HttpCompletionBlock _Nullable )completion;

- (NSURLSessionDataTask *_Nullable)doHTTPGet:(Mo9HttpReq *_Nullable)req
                              start:(HttpStartBlock _Nullable )startBlock
                         completion:(HttpCompletionBlock _Nullable )completion;

- (NSURLSessionDataTask *_Nullable)doUploadHTTPPost:(Mo9HttpReq *_Nullable)req
                 constructingBodyWithBlock:(HttpFormDataBlock _Nullable )block
                                  progress:(HttpProgressBlock _Nullable )progress
                                completion:(HttpCompletionBlock _Nullable )completion;



@end
