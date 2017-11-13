//
//  Mo9LibraryManager.h
//  mo9Library
//
//  Created by ChenJian on 2017/7/26.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "BaseManager.h"

@interface LibraryManager : BaseManager

@property (nonatomic, assign) BOOL isDebug;  //default: NO, 打印LOG设置
@property (nonatomic, assign) EnvironState appEnvironState;// default: EnvironStateProduct

@property (nonatomic, assign) AppType type; //暂时没什么用




@end
