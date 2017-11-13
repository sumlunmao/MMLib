//
//  PortraitImageView.m
//  Mo9Client
//
//  Created by ChenJian on 15/6/9.
//  Copyright (c) 2015年 mo9. All rights reserved.
//

#import "PortraitImageView.h"

@implementation PortraitImageView
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.clipsToBounds = YES;
    self.type = PortraitTypeNormal;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    if (self.type == PortraitTypeNormal) {
        self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2;
    }else if (self.type == PortraitTypeDiamond) {
        CAShapeLayer * shapLayer = [CAShapeLayer layer];
        shapLayer.path = [self getDiamondPathWithSize:self.bounds.size];
        self.layer.mask = shapLayer;
    }
}

- (CGPathRef)getDiamondPathWithSize:(CGSize)size {
    CGFloat height = size.height;
    CGFloat width = size.width;
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    //        path.lineWidth = 2;
    
    [path moveToPoint:CGPointMake(0, (height / 2))];
    
    [path addLineToPoint:CGPointMake((width / 2), 0)];
    
    [path addLineToPoint:CGPointMake(width, (height / 2))];
    
    [path addLineToPoint:CGPointMake((width / 2), height)];
    
    [path closePath];
    
    return path.CGPath;
}


- (CGPathRef)getHexagonPathWithSize:(CGSize)size {
    CGFloat height = size.height;
    CGFloat width = size.width;
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    //        path.lineWidth = 2;
    
    [path moveToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (width / 2), (height / 4))];
    
    [path addLineToPoint:CGPointMake((width / 2), 0)];
    
    [path addLineToPoint:CGPointMake(width - ((sin(M_1_PI / 180 *60)) * (width / 2)), (height / 4))];
    
    [path addLineToPoint:CGPointMake(width - ((sin(M_1_PI / 180 *60)) * (width / 2)), (height / 2) + (height/4))];
    
    [path addLineToPoint:CGPointMake((width / 2), height)];
    
    [path addLineToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) *(width / 2), (height / 2) + (height / 4))];
    
    [path closePath];

    return path.CGPath;
}





@end
