//
//  PhotoModel.m
//  Mo9Client
//
//  Created by ChenJian on 15/11/21.
//  Copyright © 2015年 mo9. All rights reserved.
//

#import "PhotoModel.h"
#import "UIImage+Kit.h"

@interface PhotoModel()
{

}

@end

@implementation PhotoModel

//- (UIImage *)image {
//    return [UIImage imageWithCGImage:_asset.defaultRepresentation.fullScreenImage];
//}



- (UIImage *)Thumbnail {
    if (self.asset) {
        return [UIImage imageWithCGImage:self.asset.thumbnail];
    }else {
        return [CommonFunction squareImageFromImage:self.image scaledToSize:100];
    }
}

- (NSString *)imageBase64String {
//    if (_asset) {
//        return [[UIImage imageWithCGImage:_asset.defaultRepresentation.fullScreenImage] imageBase64EncodeString];
//    }
//    if (_image) {
        return [_image imageBase64EncodeString];
//    }
//    return [self.image imageBase64EncodeString];
}

- (NSData *)compressedImageData {
    return [_image imageCompressedData];
}



@end
