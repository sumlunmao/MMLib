//
//  BaseViewController.h
//  Mo9SDK
//
//  Created by ChenJian on 15/5/13.
//  Copyright (c) 2015年 mo9. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^VcCallbackBlock)(NSDictionary *dic);

@interface BaseViewController : UIViewController

- (void)initData;
- (void)initUI;

- (void)baseDealloc;

@property (nonatomic, strong) NSDictionary* bundle;
@property (nonatomic, copy) VcCallbackBlock callbackBlock;


- (void)backAction;
- (void)backActionWithAnimate:(BOOL)animated;

- (void)addDismssBtnIsLeft:(BOOL)isLeft;
- (void)dismissVC;


/**
 *  override
 *
 *  notification
 */

- (void)addNotification:(NSString *)name method:(SEL)method object:(id)obj;

- (void)notificationTokenInvalid:(NSNotification*)notification;

- (void)postNotification:(NSString*)name object:(id)obj;

- (void)postNotification:(NSString *)name object:(id)obj userInfo:(NSDictionary *)dic;


//get VC
- (BaseViewController *)getVCWithStoryboardName:(NSString *)storyName vcName:(NSString *)vcName;
- (BaseViewController *)getVCWithVcName:(NSString *)vcName;

/**
 * vc
 */
- (void)pushVcName:(NSString*)vcName params:(NSDictionary*)parmas;
- (void)pushVcName:(NSString*)vcName params:(NSDictionary*)parmas resultBlock:(VcCallbackBlock)block;
- (void)pushVcName:(NSString*)vcName params:(NSDictionary*)parmas resultBlock:(VcCallbackBlock)block animated:(BOOL)animated;

- (void)presentVcName:(NSString*)vcName params:(NSDictionary*)parmas;
- (void)presentVcName:(NSString*)vcName params:(NSDictionary*)parmas resultBlock:(VcCallbackBlock)block;

/**
 * storyboard
 */

- (void)pushNextPage:(NSString*)storyName vcName:(NSString*)vcName params:(NSDictionary*)parmas;
- (void)pushNextPage:(NSString*)storyName vcName:(NSString*)vcName params:(NSDictionary*)parmas resultBlock:(VcCallbackBlock)block;
- (void)pushNextPage:(NSString *)storyName vcName:(NSString *)vcName params:(NSDictionary *)parmas animated:(BOOL)animated resultBlock:(VcCallbackBlock)block;

- (void)presentNextPage:(NSString*)storyName vcName:(NSString*)vcName params:(NSDictionary*)parmas;
- (void)presentNextPage:(NSString *)storyName vcName:(NSString *)vcName params:(NSDictionary *)parmas resultBlock:(VcCallbackBlock)block;


@end
