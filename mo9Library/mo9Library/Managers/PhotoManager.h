//
//  PhotoManager.h
//  mo9Library
//
//  Created by ChenJian on 2017/8/2.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import <mo9Library/mo9Library.h>

typedef void (^PhotoBlock)(NSArray *images);

@interface PhotoManager : BaseManager

- (void)takePhotoMaxCount:(NSUInteger)count withPresentVC:(UIViewController *)vc completion:(PhotoBlock)completion;
- (void)takePhotoOnlyMaxCount:(NSUInteger)count withPresentVC:(UIViewController *)vc completion:(PhotoBlock)completion;
- (void)takeCameraOnlyWithPresentVC:(UIViewController *)vc completion:(PhotoBlock)completion;
- (void)takepPortraitWithPresentVC:(UIViewController *)vc completion:(PhotoBlock)completion;

@end
