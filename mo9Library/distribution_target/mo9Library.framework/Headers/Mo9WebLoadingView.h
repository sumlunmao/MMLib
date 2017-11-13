//
//  WebLoadingView.h
//  testJs
//
//  Created by mouh on 2017/5/16.
//  Copyright © 2017年 mouh. All rights reserved.
//
/**
 *  加载web页的通用加载动画效果
 *  动画的使用：
 *  开始动画：在要开始的地方如此调用：[WebLoadingView startLoadingWithView:view animate:true];或者[WebLoadingView startLoadingAnimate:true]；
 *  结束动画：在要结束的地方如此调用：[WebLoadingView finishLoadingWithView:view animate:true];或者[WebLoadingView finishLoadingAnimate:true];
 */

#import <UIKit/UIKit.h>

#define MaxPageCount 20

//loadingImageName : web_loading1~20
@interface Mo9WebLoadingView : UIView


/**
 开始加载动画

 @param view 动画父控件
 @param animate 是否开启渐进动画加载
 */
+ (void)startLoadingWithView:(UIView *)view animate:(BOOL)animate;

/**
 结束加载动画

 @param view 动画父控件
 @param animate 是否开启渐进动画消失
 */
+ (void)finishLoadingWithView:(UIView *)view animate:(BOOL)animate;


/**
 开始window上的动画
 @param animate 是否开启渐进动画加载
 */
+ (void)startLoadingAnimate:(BOOL)animate;

/**
 结束window上的动画

 @param animate 是否开启渐进动画消失
 */
+ (void)finishLoadingAnimate:(BOOL)animate;



@end
