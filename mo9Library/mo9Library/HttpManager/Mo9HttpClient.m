//
//  Mo9StandardHttpClient.m
//  Mo9Client
//
//  Created by ChenJian on 2017/3/13.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "Mo9HttpClient.h"
#import "Mo9HttpResp.h"
#import "ExceptionManager.h"
#import <AFNetworking/AFNetworking.h>
@interface Mo9HttpClient()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, copy) ServerConfigBlock block;
@end

@implementation Mo9HttpClient

+ (Mo9HttpClient *)defaultHttpClient {
    return [Mo9HttpClient defaultHttpClientWithConfig:nil];
}

+ (Mo9HttpClient *)httpClientWithServerType:(ServerType)type {
    return [Mo9HttpClient httpClientWithServerType:type configBlock:nil];
}

+ (Mo9HttpClient *)defaultHttpClientWithConfig:(ServerConfigBlock)block {
    return [[[self class] alloc] initWithBaseUrlStr:[Infrastructure getConfigManager].defaultServerUrl configBlock:block];
}

+ (Mo9HttpClient *)httpClientWithServerType:(ServerType)type configBlock:(ServerConfigBlock)block {
    return [[[self class] alloc] initWithBaseUrlStr:[[Infrastructure getConfigManager] serverUrlWithType:type] configBlock:block];
}

+ (Mo9HttpClient *)httpClientWithBaseUrl:(NSString *)baseUrl configBlock:(ServerConfigBlock)block {
    return [[[self class] alloc] initWithBaseUrlStr:baseUrl configBlock:block];
}
    
- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(nonnull NSString *)field {
    [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

- (id)init {
    return [self initWithBaseUrlStr:[Infrastructure getConfigManager].defaultServerUrl configBlock:nil];
}

- (id)initWithBaseUrlStr:(NSString *)urlStr configBlock:(ServerConfigBlock)block{
    self = [super init];
    if (self) {
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:urlStr]];
        self.sessionManager.securityPolicy.allowInvalidCertificates = YES;
        self.sessionManager.securityPolicy.validatesDomainName = NO;
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.sessionManager.requestSerializer setValue:[[Infrastructure getConfigManager] client_Id] forHTTPHeaderField:@"Client-Id"];
        [self.sessionManager.requestSerializer setValue:[[Infrastructure getConfigManager] appBuildVersion] forHTTPHeaderField:@"Client-Version"];
        [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"content-type"];
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",nil];
        if (block) {
            NSDictionary *configDic = block();
            if (configDic) {
                for (NSString *key in configDic.allKeys) {
                    [self.sessionManager.requestSerializer setValue:configDic[key] forHTTPHeaderField:key];
                }
            }
        }
    }
    return self;
}

- (NSURLSessionDataTask *)doHTTPPost:(Mo9HttpReq *)req
                               start:(HttpStartBlock)startBlock
                          completion:(HttpCompletionBlock)completion
{
    req.methodType = HttpMethodTypePost;
    [self.sessionManager.requestSerializer setValue:req.timestamp forHTTPHeaderField:@"Timestamp"];
    [self.sessionManager.requestSerializer setValue:req.sign forHTTPHeaderField:@"Sign"];
    
    NSMutableURLRequest *request = [self.sessionManager.requestSerializer requestWithMethod:kHttpMethodPost
                                                                                  URLString:[NSString stringWithFormat:@"%@%@",self.sessionManager.baseURL.absoluteString,req.api]
                                                                                 parameters:req.params
                                                                                      error:nil];
    if (req.timeoutSeconds) {
        request.timeoutInterval = req.timeoutSeconds.doubleValue;
    }else
        request.timeoutInterval = kTimeoutInterval;

    Log(@"requestUrl:%@",request.URL);
    Log(@"params:%@",req.params);
    Log(@"HTTPRequestHeaders:%@",self.sessionManager.requestSerializer.HTTPRequestHeaders);
    NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithRequest:request
                                                               uploadProgress:nil
                                                             downloadProgress:nil
                                                            completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                                if (!error) {
                                                                    Log(@"response:%@",responseObject);
                                                                    Mo9HttpResp *resp = [[Mo9HttpResp alloc] initWithDictionary:responseObject];
                                                                    if (completion != nil) {
                                                                        if ([Infrastructure getExceptionManager].exceptionCallBackBlock != nil) {
                                                                            [Infrastructure getExceptionManager].exceptionCallBackBlock(response,resp);
                                                                        }
                                                                        completion(req,resp);
                                                                    }
                                                                }else {
                                                                    Log(@"Request Failed with ERROR ...\nerror = %@\nuserInfo = %@\nApi = %@", error, error.userInfo, req.api);
                                                                    if(completion != nil) {
                                                                        Mo9HttpResp *resp = [[Mo9HttpResp alloc] initWithError:error];
                                                                        if ([Infrastructure getExceptionManager].exceptionCallBackBlock != nil) {
                                                                            [Infrastructure getExceptionManager].exceptionCallBackBlock(response,resp);
                                                                        }
                                                                        completion(req,resp);
                                                                    }
                                                                }
                                                            }];
    [dataTask resume];
    if (startBlock) {
        startBlock(req);
    }
    return dataTask;
}

- (NSURLSessionDataTask *)doHTTPGet:(Mo9HttpReq *)req
                              start:(HttpStartBlock)startBlock
                         completion:(HttpCompletionBlock)completion
{
    
    req.methodType = HttpMethodTypeGet;
    
    [self.sessionManager.requestSerializer setValue:req.timestamp forHTTPHeaderField:@"Timestamp"];
    [self.sessionManager.requestSerializer setValue:req.sign forHTTPHeaderField:@"Sign"];

    
    NSMutableURLRequest *request = [self.sessionManager.requestSerializer requestWithMethod:kHTTPMethodGet
                                                                                  URLString:[NSString stringWithFormat:@"%@%@",self.sessionManager.baseURL.absoluteString,req.api]
                                                                                 parameters:req.params
                                                                                      error:nil];
    if (req.timeoutSeconds) {
        request.timeoutInterval = req.timeoutSeconds.doubleValue;
    } else
        request.timeoutInterval = kTimeoutInterval;
    Log(@"requestUrl:%@",request.URL);
    Log(@"params:%@",req.params);
    Log(@"HTTPRequestHeaders:%@",self.sessionManager.requestSerializer.HTTPRequestHeaders);
    NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithRequest:request
                                                               uploadProgress:nil
                                                             downloadProgress:nil
                                                            completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                                if (!error) {
                                                                    Log(@"response:%@",responseObject);
                                                                    if (completion != nil) {
                                                                        Mo9HttpResp *resp = [[Mo9HttpResp alloc] initWithDictionary:responseObject];
                                                                        if ([Infrastructure getExceptionManager].exceptionCallBackBlock != nil) {
                                                                            [Infrastructure getExceptionManager].exceptionCallBackBlock(response,resp);
                                                                        }
                                                                        completion(req,resp);
                                                                    }
                                                                }else {
                                                                    Log(@"Request Failed with ERROR ...\nerror = %@\nuserInfo = %@\nApi = %@", error, error.userInfo, req.api);
                                                                    if(completion != nil) {
                                                                        Mo9HttpResp *resp = [[Mo9HttpResp alloc] initWithError:error];
                                                                        if ([Infrastructure getExceptionManager].exceptionCallBackBlock != nil) {
                                                                            [Infrastructure getExceptionManager].exceptionCallBackBlock(response,resp);
                                                                        }
                                                                        completion(req,resp);
                                                                    }
                                                                }
                                                            }];
    [dataTask resume];
    if (startBlock) {
        startBlock(req);
    }
    return dataTask;
}
- (NSURLSessionDataTask *)doUploadHTTPPost:(Mo9HttpReq *)req
                 constructingBodyWithBlock:(HttpFormDataBlock)block
                                  progress:(HttpProgressBlock)progress
                                completion:(HttpCompletionBlock)completion {
    
    
    NSURLSessionDataTask *dataTask = [self.sessionManager POST:[NSString stringWithFormat:@"%@%@",self.sessionManager.baseURL,req.api]
                                                    parameters:req.params
                                     constructingBodyWithBlock:block
                                                      progress:^(NSProgress * _Nonnull uploadProgress) {
                                                          dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                              if (progress) {
                                                                  progress(uploadProgress);
                                                              }
                                                          });
                                                      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                          Log(@"response:%@",responseObject);
                                                          if (completion != nil) {
                                                              Mo9HttpResp *resp = [[Mo9HttpResp alloc] initWithDictionary:responseObject];
                                                              completion(req,resp);
                                                          }
                                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                          if(completion != nil) {
                                                              Mo9HttpResp *resp = [[Mo9HttpResp alloc] initWithError:error];
                                                              if ([Infrastructure getExceptionManager].exceptionCallBackBlock != nil) {
                                                                  [Infrastructure getExceptionManager].exceptionCallBackBlock((NSHTTPURLResponse *)task.response,resp);
                                                              }
                                                              completion(req,resp);
                                                          }
                                                      }];
    return  dataTask;
}


@end
