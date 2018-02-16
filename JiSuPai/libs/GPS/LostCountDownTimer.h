//
//  LostTimer.h
//  JiSuPai
//
//  Created by Lost on 2018/2/10.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TimerBlock)();

@interface LostCountDownTimer : NSObject

- (void)startTimerWithBlock:(TimerBlock)timerBlock;
- (void)stopTimer;

@end
