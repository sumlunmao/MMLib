//
//  BaseView.m
//  Mo9Client
//
//  Created by ChenJian on 15/6/23.
//  Copyright (c) 2015年 mo9. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
}

- (void)postNotification:(NSString *)name object:(id)obj {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];
}

@end
