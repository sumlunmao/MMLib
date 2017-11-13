//
//  BatteryStateManager.h
//  Mo9Client
//
//  Created by mo9 on 2017/7/18.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "BaseManager.h"

@interface CommonManager : BaseManager
/**电池电量*/
@property (nonatomic,copy)NSString * batteryValue;
/**是否连接usb*/
@property (nonatomic,strong)NSNumber * usbConnected;
/**设置时间戳和服务时间戳的差值： 服务时间戳 = 设备时间戳 + 差值 （每次请求都会更新这个值）*/
@property (nonatomic, assign)   double timestampDelta;

@end
