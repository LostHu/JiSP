//
//  LostTimer.m
//  JiSuPai
//
//  Created by Lost on 2018/2/10.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "LostCountDownTimer.h"

@interface LostCountDownTimer ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) TimerBlock timerBlock;

@end

@implementation LostCountDownTimer
- (void)startTimerWithBlock:(TimerBlock)timerBlock {
    
    self.timer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(_timerAction) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    _timerBlock = timerBlock;
    
}

- (void)_timerAction {
    if (self.timerBlock) {
        self.timerBlock();
    }
}

- (void)stopTimer {
    [self.timer invalidate];
}

@end
