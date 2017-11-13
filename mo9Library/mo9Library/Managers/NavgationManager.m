//
//  Mo9NavgationManager.m
//  Mo9Client
//
//  Created by ChenJian on 2017/3/27.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "NavgationManager.h"
@interface NavgationManager()
@property (nonatomic, copy) NSString *Mo9Host;
@property (nonatomic, copy) NSString *Mo9CommonHost;
@end

@implementation  NavgationManager

#define kURL_Prefix @"mo9://com.mo9.app."
#define kCommonName @"commonloan"
#define kAppName @"xinyongqianbao"

//demo:  mo9://com.mo9.xinyongqianbao/userdetail?userid=19&Hashid=11&view=detail#tab=2

+ (BaseManager *)manager {
    static NavgationManager *__manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manage = [[NavgationManager alloc] init];
    });
    return __manage;
}

- (id)init {
    self = [super init];
    if (self) {
        self.Mo9Host = [NSString stringWithFormat:@"%@%@",kURL_Prefix,kAppName];
        self.Mo9CommonHost = [NSString stringWithFormat:@"%@%@",kURL_Prefix,kCommonName];
    }
    return self;
}







@end
