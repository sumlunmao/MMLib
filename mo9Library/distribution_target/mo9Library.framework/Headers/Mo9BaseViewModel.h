//
//  Mo9BaseViewModel.h
//  Mo9Client
//
//  Created by ChenJian on 2017/3/16.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBackArray)(id arr,NSError *error);

typedef void(^CallBackModel)(id model,NSError *error);

typedef void (^CallBackResult)(BOOL success, NSError *error);

@interface Mo9BaseViewModel : NSObject

- (void)clean;

@end
