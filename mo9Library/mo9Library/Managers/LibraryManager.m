//
//  Mo9LibraryManager.m
//  mo9Library
//
//  Created by ChenJian on 2017/7/26.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "LibraryManager.h"

@implementation LibraryManager

+ (BaseManager *)manager {
    static LibraryManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[LibraryManager alloc] init];
    });
    return _manager;
}

- (id)init {
    self = [super init];
    if (self) {
        self.appEnvironState = EnvironStateProduct;
        self.isDebug = NO;
    }
    return self;
}

@end
