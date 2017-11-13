//
//  Infrastructure.m
//  Mo9Client
//
//  Created by ChenJian on 2017/4/14.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "Infrastructure.h"

@implementation Infrastructure

+ (LibraryManager *)getLibraryManager {
    return (LibraryManager *)[LibraryManager manager];
}

+ (NavgationManager *)getNavgatioinManager {
    return (NavgationManager *)[NavgationManager manager];
}

+ (ExceptionManager *)getExceptionManager {
    return (ExceptionManager *)[ExceptionManager manager];
}

+ (ConfigManager *)getConfigManager {
    return (ConfigManager *)[ConfigManager manager];
}

+ (ViewManager *)getViewManager {
    return (ViewManager *)[ViewManager manager];
}

+ (ResManager *)getResManager {
    return (ResManager *)[ResManager manager];
}

+ (LocationManager *)getLocationManager {
    return (LocationManager *)[LocationManager manager];
}

+ (UserDefaultUtils *)getUserDefaultUtils {
    return (UserDefaultUtils *)[UserDefaultUtils manager];
}

+ (VerificationCodeManager *)getVerificationCodeManager {
    return (VerificationCodeManager *)[VerificationCodeManager manager];
}

+ (LibsManager *)getLibsManager {
    return (LibsManager *)[LibsManager manager];
}

+ (CommonManager *)getCommonManager {
    return (CommonManager *)[CommonManager manager];
}

+ (PhotoManager *)getPhotoManager {
    return (PhotoManager *)[PhotoManager manager];
}

@end
