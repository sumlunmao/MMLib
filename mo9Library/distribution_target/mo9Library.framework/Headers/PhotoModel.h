//
//  PhotoModel.h
//  Mo9Client
//
//  Created by ChenJian on 15/11/21.
//  Copyright © 2015年 mo9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoModel : NSObject

@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, strong) UIImage *image;

- (UIImage *)Thumbnail;

- (NSData *)compressedImageData;

- (NSString *)imageBase64String;

@end
