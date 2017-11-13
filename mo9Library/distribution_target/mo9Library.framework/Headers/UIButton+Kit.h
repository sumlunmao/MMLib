//
//  UIButton+Kit.h
//  Mo9Client
//
//  Created by mouh on 2017/5/16.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Kit)

/**
 设置button扩大响应区域的区域

 @param top 上方
 @param right 右方
 @param bottom 下方
 @param left 左方
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

/**
 设置button扩大响应区域的区域（上下左右同时扩大）

 @param size 扩大的尺寸
 */
- (void)setEnlargeEdge:(CGFloat)size;

@end
