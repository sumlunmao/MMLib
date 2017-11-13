//
//  TimerCountBtn.h
//  MasterPu
//
//  Created by FlyingPig on 15/3/12.
//  Copyright (c) 2015年 masterpu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define maxSeconds   60
@interface TimerCountBtn : UIButton

- (void)startCount; //从maxSeconds开始倒数

- (void)startCountWithMaxSeconds:(NSUInteger)seconds;

@end
