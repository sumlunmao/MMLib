//
//  UIImage+Kit.m
//  NeiTao
//
//  Created by ChenJian on 12/23/14.
//  Copyright (c) 2014 NeiTao. All rights reserved.
//

#import "UIImage+Kit.h"

@implementation UIImage(category)

- (UIImage *)compressedImage {
    CGFloat maxLength = self.size.width>self.size.height?self.size.width:self.size.height;
    CGFloat ratio = 1;
    UIImage *img = self;
    if (maxLength>1200) {
        ratio = 1200.0/maxLength;
        CGSize size = CGSizeMake(self.size.width*ratio, self.size.height*ratio);
        img = [self imageByScalingToSize:size];
    }
    NSData *data = UIImageJPEGRepresentation(img, kCompressedValue);
    return [UIImage imageWithData:data];
}

- (NSString *)imageBase64EncodeString {
    NSData *data = UIImageJPEGRepresentation(self, kCompressedValue);
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (NSData *)imageCompressedData {
    return UIImageJPEGRepresentation(self, kCompressedValue);
}

- (UIImage *)imageByScalingToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = self;
    
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    
    CGFloat scaledWidth = targetWidth;
    
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            
            scaleFactor = widthFactor;
        
        else
            
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            
            
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        } else if (widthFactor > heightFactor) {
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            
        }
        
    }
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    
    thumbnailRect.origin = thumbnailPoint;
    
    thumbnailRect.size.width  = scaledWidth;
    
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext(); 
    
    UIGraphicsEndImageContext(); 
    
    if(newImage == nil) 
        
        NSLog(@"could not scale image");   
    
    return newImage ; 
}

+ (UIImage *)imageWithUIColor:(UIColor *)color size:(CGSize )size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return transparentImage;
}

+ (UIImage *)imageDecodeFromBase64:(NSString *)base64Str {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64Str options:0];
    UIImage *image = [[UIImage alloc] initWithData:data];
    return image;
}
@end
