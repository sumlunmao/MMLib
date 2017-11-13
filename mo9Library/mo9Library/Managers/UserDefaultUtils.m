//
//  Mo9UserDefaultManagement.m
//  Mo9Mokredit
//
//  Created by ChenJian on 14-9-9.
//  Copyright (c) 2014年 Mo9. All rights reserved.
//

#import "UserDefaultUtils.h"
@interface UserDefaultUtils()
{
}

@end
@implementation UserDefaultUtils
@dynamic accessToken;

#define kUDToken @"accessToken"

+ (UserDefaultUtils *)manager {
    static UserDefaultUtils *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[UserDefaultUtils alloc] init];
    });
    return __instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)setAccessToken:(NSString *)accessToken {
    [self.defaults setObject:accessToken?:@"" forKey:kUDToken];
    [self.defaults synchronize];
}

- (NSString *)accessToken {
    return [self.defaults objectForKey:kUDToken]?:@"";
}

#pragma; mark ---- common methods ----
+ (void)saveCustomObject:(id)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
}

+ (void)saveBool:(BOOL)value key:(NSString*)key {
    if([key length] == 0)
        return;
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
}

+ (void)saveObject:(id)value key:(NSString *)key {
    if(value == nil)
        return;
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

+ (BOOL)boolWithKey:(NSString *)key {
    if([key length] == 0)
        return NO;
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (id)objectWithKey:(NSString *)key {
    if([key length] == 0)
        return nil;
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (id)customObjectWithKey:(NSString *)key {
    if([key length] == 0)
        return nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    if(encodedObject == nil)
        return nil;
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

+ (void)emptyDefaultWithKey:(NSString *)key {
    if([key length] == 0)
        return;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
