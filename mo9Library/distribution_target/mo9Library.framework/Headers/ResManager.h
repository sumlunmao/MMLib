//
//  ResManager.h
//  Mo9Client
//
//  Created by ChenJian on 2017/4/27.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "BaseManager.h"

@interface ResManager : BaseManager

- (NSString *)resBundlePath;

- (NSURL *)configPath;
- (NSURL *)vcConfigPath;
- (NSURL *)styleConfigPath;
- (NSURL *)serverConfigPath;

- (NSURL *)provincePath;

- (NSURL *)errorCodePath;

- (NSString *)imagePath;

@end
