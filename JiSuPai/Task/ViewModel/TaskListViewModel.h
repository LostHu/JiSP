//
//  TaskListViewModel.h
//  JiSuPai
//
//  Created by Lost on 2018/1/13.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "BaseViewModel.h"
#import "TaskData.h"

#define AllDate [NSDate dateWithString:@"1900-01-01" format:@"yyyy-MM-dd"]

@interface TaskListViewModel : BaseTableViewModel

@property (nonatomic, strong) NSDate* date;
@property (nonatomic, strong) NSArray* resultArray;

- (void)cancelTask:(TaskData*)task;
- (void)startTask:(TaskData*)task;
- (void)endTask:(TaskData*)task;
- (void)firstTask:(TaskData*)task;
@end
