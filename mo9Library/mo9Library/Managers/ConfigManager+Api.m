//
//  URLManager(Category).m
//  Mo9Client
//
//  Created by ChenJian on 2017/5/8.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "ConfigManager+Api.h"

@implementation ConfigManager(ApiUrl)

- (NSString *)serverUrlWithType:(ServerType)type {
    NSString *typeStr = [self stringWithServerType:type];
    NSString *environStr = [self environString];
    NSString *urlStr = self.serverDic[@"ServerType"][typeStr][environStr];
    Log(@"type:%@ environ:%@ ServerUrl:%@",typeStr,environStr,urlStr);
    return urlStr;
}

- (NSString *)defaultServerUrl {
    NSString *urlStr = [self serverUrlWithType:(ServerType)[self.serverDic[@"DefaultType"] integerValue]];
    return urlStr;
}

- (NSString *)environString {
    return [self stringWithAppEnvironState:[Infrastructure getLibraryManager].appEnvironState];
}


- (NSString *)stringWithAppEnvironState:(EnvironState)state {
    NSString *stateStr = @"";
    switch (state) {
        case EnvironStateDev:
            stateStr = @"dev";
            break;
        case EnvironStateClone:
            stateStr = @"clone";
            break;
        case EnvironStatePre:
            stateStr = @"pre";
            break;
        case EnvironStateProduct:
            stateStr = @"product";
            break;
        default:
            break;
    }
    return stateStr;
}

- (NSString *)stringWithServerType:(ServerType)type {
    NSString *typeStr = @"";
    switch (type) {
        case ServerTypeLBT:
            typeStr = @"lubuting";
            break;
        case ServerTypeQJJ:
            typeStr = @"qianjiujiu";
            break;
        case ServerTypeAccount:
            typeStr = @"account";
            break;
        case ServerTypePromote:
            typeStr = @"promote";
            break;
        default:
            break;
    }
    return typeStr;
}

@end
