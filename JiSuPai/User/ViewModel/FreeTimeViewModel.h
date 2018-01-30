//
//  FreeTimeViewModel.h
//  JiSuPai
//
//  Created by Lost on 2018/1/21.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "BaseViewModel.h"
#import "FreeTimeData.h"

@interface FreeTimeViewModel : BaseTableViewModel
@property (nonatomic, strong) NSArray* arrayHour;
@property (nonatomic, strong) NSArray* arrayMin;

@property (nonatomic, strong) NSDate* startDate;
@property (nonatomic, strong) NSDate* endDate;
@property (nonatomic, strong) NSString* startTime;
@property (nonatomic, strong) NSString* endTime;

- (void)addFreeTime:(ModelCompleteBlock)block;
- (void)delFreeTime:(FreeTimeData*)freeTime block:(ModelCompleteBlock)block;
@end
