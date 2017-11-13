//
//  ConfigManager+Copyright.m
//  Mo9Client
//
//  Created by sunlunmao on 2017/7/17.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "ConfigManager+Copyright.h"

@implementation ConfigManager (Copyright)

- (NSString *)chineseCompanyName;
{
    return [self copyRightDictionary][@"chineseCompanyName"];
}

- (NSString *)englishCompanyName;
{
    return [self copyRightDictionary][@"englishCompanyName"];
}

#pragma mark - private function
- (NSDictionary *)copyRightDictionary;
{
    return self.configDic[@"copyRight"];
}

@end
