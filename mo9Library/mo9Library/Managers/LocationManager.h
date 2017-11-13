//
//  LocationManager.h
//  Mo9Client
//
//  Created by ChenJian on 15/11/20.
//  Copyright © 2015年 mo9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "BaseManager.h"

#define Location_locating @"定位中..."
#define Error_Location @"定位失败"

typedef void(^LocationResult)(NSString *city);
typedef void(^LocationDetailResult)(NSString *city,CLLocation *location);

@interface LocationManager : BaseManager
@property (nonatomic,assign) CLLocation *location;

- (void)startLocationCompletion:(LocationResult)completion;

@end
