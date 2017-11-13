//
//  URLManager(Category).h
//  Mo9Client
//
//  Created by ChenJian on 2017/5/8.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "ConfigManager.h"
@interface ConfigManager(ApiUrl)

- (NSString *)serverUrlWithType:(ServerType)type;

- (NSString *)defaultServerUrl;

@end
