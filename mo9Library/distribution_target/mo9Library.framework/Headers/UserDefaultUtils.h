//
//  Mo9UserDefaultManagement.h
//  Mo9Mokredit
//
//  Created by ChenJian on 14-9-9.
//  Copyright (c) 2014年 Mo9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mo9Contants.h"
#import "BaseManager.h"

@interface UserDefaultUtils : BaseManager

@property (nonatomic, strong) NSUserDefaults *defaults;

@property (nonatomic, assign) NSString *accessToken;



/**
 *  保存自定义object到defaults
 *
 *  @param object object
 *  @param key    key
 */
+ (void)saveCustomObject:(id)object key:(NSString *)key;

+ (void)saveBool:(BOOL)value key:(NSString*)key;

+ (void)saveObject:(id)value key:(NSString*)key;

/**
 *  从defaults中获取保存的值
 *
 *  @param key key
 *
 *  @return value or object
 */
+ (BOOL)boolWithKey:(NSString*)key;

+ (id)objectWithKey:(NSString*)key;

+ (id)customObjectWithKey:(NSString *)key;

+ (void)emptyDefaultWithKey:(NSString *)key;
@end
