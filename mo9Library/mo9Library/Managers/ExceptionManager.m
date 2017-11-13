//
//  ExceptionManager.m
//  Mo9Client
//
//  Created by mo9 on 2017/4/17.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "ExceptionManager.h"

@implementation ExceptionManager

+ (ExceptionManager *)manager{
    static ExceptionManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ExceptionManager alloc] init];
    });
    return manager;
}
@end
