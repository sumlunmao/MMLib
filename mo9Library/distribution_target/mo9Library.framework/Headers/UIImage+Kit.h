//
//  UIImage+Kit.h
//  NeiTao
//
//  Created by ChenJian on 12/23/14.
//  Copyright (c) 2014 NeiTao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCompressedValue 0.3

@interface UIImage(category)

- (UIImage *)compressedImage;

- (NSString *)imageBase64EncodeString;

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

- (NSData *)imageCompressedData;

+ (UIImage *)imageWithUIColor:(UIColor *)color size:(CGSize )size;

+ (UIImage *)imageDecodeFromBase64:(NSString *)base64Str;
@end
