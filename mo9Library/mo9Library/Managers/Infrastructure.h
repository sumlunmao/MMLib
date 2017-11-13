//
//  Infrastructure.h
//  Mo9Client
//
//  Created by ChenJian on 2017/4/14.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NavgationManager.h"
#import "ExceptionManager.h"
#import "ConfigManager.h"
#import "ViewManager.h"
#import "ResManager.h"
#import "LocationManager.h"
#import "UserDefaultUtils.h"
#import "ConfigManager+Api.h"
#import "ConfigManager+Style.h"
#import "ConfigManager+Theme.h"
#import "VerificationCodeManager.h"
#import "LibsManager.h"
#import "CommonManager.h"
#import "PhotoManager.h"
#import "LibraryManager.h"


@interface Infrastructure : NSObject

+ (LibraryManager *)getLibraryManager;

+ (NavgationManager *)getNavgatioinManager;

+ (ExceptionManager *)getExceptionManager;

+ (ConfigManager *)getConfigManager;

+ (ViewManager *)getViewManager;

+ (ResManager *)getResManager;

+ (LocationManager *)getLocationManager;

+ (UserDefaultUtils *)getUserDefaultUtils;

+ (VerificationCodeManager *)getVerificationCodeManager;

+ (LibsManager *)getLibsManager;

+ (CommonManager *)getCommonManager;

+ (PhotoManager *)getPhotoManager;

@end
