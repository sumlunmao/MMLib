//
//  ResManager.m
//  Mo9Client
//
//  Created by ChenJian on 2017/4/27.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "ResManager.h"

@implementation ResManager

+ (BaseManager *)manager {
    static ResManager *__manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[ResManager alloc] init];
    });
    return __manager;
}

- (NSString *)resBundlePath {
    NSString *resPath =  [[NSBundle mainBundle] pathForResource:@"Library"
                                                         ofType:@"bundle"];
    return resPath;
}

- (NSURL *)configPath {
    NSURL *url =  [[NSBundle bundleWithPath:[self resBundlePath]] URLForResource:@"Config" withExtension:@"plist"];
    return url;
}

- (NSURL *)vcConfigPath {
    NSURL *url =  [[NSBundle bundleWithPath:[self resBundlePath]] URLForResource:@"VcConfig" withExtension:@"plist"];
    return url;
}

- (NSURL *)styleConfigPath {
    NSURL *url = [[NSBundle bundleWithPath:[self resBundlePath]] URLForResource:@"StyleConfig" withExtension:@"plist"];
    return url;
}

- (NSURL *)serverConfigPath {
    NSURL *url = [[NSBundle bundleWithPath:[self resBundlePath]] URLForResource:@"Server" withExtension:@"plist"];
    return url;
}

- (NSURL *)provincePath {
    NSURL *url = [[NSBundle bundleWithPath:[self resBundlePath]] URLForResource:@"address" withExtension:@"plist"];
    return url;
}


- (NSURL *)errorCodePath {
    NSURL *url = [[NSBundle bundleWithPath:[self resBundlePath]] URLForResource:@"ErrorCode" withExtension:@"plist"];
    return url;
}

- (NSString *)imagePath {
    NSString *path = [[NSBundle bundleWithPath:[self resBundlePath]] pathForResource:@"Images" ofType:@"bundle"];
    return path;
}

@end
