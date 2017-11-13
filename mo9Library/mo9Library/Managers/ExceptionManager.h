//
//  ExceptionManager.h
//  Mo9Client
//
//  Created by mo9 on 2017/4/17.
//  Copyright © 2017年 mo9. All rights reserved.
//

//异常处理manager
#import <Foundation/Foundation.h>
#import "BaseManager.h"
#import "Mo9HttpResp.h"

typedef void(^exceptionMannagerCallBackBlock)(NSURLResponse * response,Mo9HttpResp * responseObject);

@interface ExceptionManager : BaseManager

@property (nonatomic,copy)exceptionMannagerCallBackBlock exceptionCallBackBlock;

@end
