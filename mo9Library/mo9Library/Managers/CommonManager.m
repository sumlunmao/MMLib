//
//  BatteryStateManager.m
//  Mo9Client
//
//  Created by mo9 on 2017/7/18.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "CommonManager.h"

@implementation CommonManager

+(CommonManager *)manager {
    static CommonManager *__manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[CommonManager alloc] init];
    });
    return __manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //电池的状态是可监听的
        [UIDevice currentDevice].batteryMonitoringEnabled = YES;
        //获取电池的状态
        switch ([UIDevice currentDevice].batteryState) {
            case UIDeviceBatteryStateUnknown:
                Log(@"电池的状态未知");
                self.usbConnected = [NSNumber numberWithInt:0];
                break;
            case UIDeviceBatteryStateCharging:
                Log(@"电池正在充电");
                self.usbConnected = [NSNumber numberWithInt:1];
                break;
            case UIDeviceBatteryStateUnplugged:
                Log(@"电池未充电");
                self.usbConnected = [NSNumber numberWithInt:0];
                break;
            case UIDeviceBatteryStateFull:
                Log(@"电池电量充满");
                self.usbConnected = [NSNumber numberWithInt:0];
                break;
            default:
                break;
        }
        //获取当前电池的电量
        Log(@"当前电池的电量百分比是%3.0f%%",([[UIDevice currentDevice] batteryLevel]) *100);
        self.batteryValue = [NSString stringWithFormat:@"%3.0f%%",([[UIDevice currentDevice] batteryLevel]) *100];
    }
    return self;
}
@end
