//
//  TimerCountBtn.m
//  MasterPu
//
//  Created by FlyingPig on 15/3/12.
//  Copyright (c) 2015年 masterpu. All rights reserved.
//

#import "TimerCountBtn.h"
#import "UIColor+Kit.h"
@interface TimerCountBtn()
{
    
}
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSUInteger seconds;
@end

@implementation TimerCountBtn


-(void)awakeFromNib {
    [super awakeFromNib];
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
}

- (void)startCount {
    [self startCountWithMaxSeconds:maxSeconds];
}

- (void)startCountWithMaxSeconds:(NSUInteger)seconds {
    self.seconds = seconds;
}
-(void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeUpdate) userInfo:nil repeats:YES];
}
- (void)timeUpdate {
   
    if (_seconds <= 0) {
        [self stopCount];
        return;
    }
     self.enabled = NO;
    [self setTitle:[NSString stringWithFormat:@"%zd秒后重发",_seconds] forState:UIControlStateNormal];
    _seconds--;
}

- (void)stopCount {
    [self.timer invalidate];
    self.timer = nil;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.enabled = YES;
}
-(void)setSeconds:(NSUInteger)seconds {
    _seconds = seconds;
    if (self.enabled == NO) {
        [self stopCount];
    }
    if (seconds > 0) {
        [self addTimer];
    }
}

-(void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}
@end
