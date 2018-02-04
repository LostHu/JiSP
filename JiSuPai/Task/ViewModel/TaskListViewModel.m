//
//  TaskListViewModel.m
//  JiSuPai
//
//  Created by Lost on 2018/1/13.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TaskListViewModel.h"

@implementation TaskListViewModel

- (void)setDate:(NSDate *)date
{
    _date = date;
    if ([date isEqualToDate:AllDate]) {
        if (self.array.count > 0)
            self.resultArray = self.array;
        else
            self.resultArray = nil;
        return;
    }
        
    if (self.array.count > 0) {
        NSString* nowDate = [LostTimer parseDate:[_date timeIntervalSince1970]];
        NSMutableArray* tempArray = [NSMutableArray array];
        for (int i = 0; i<self.array.count; i++) {
            TaskData *task = [self.array objectAtIndex:i];
            if ([task.orderdate isEqualToString:nowDate]) {
                [tempArray addObject:task];
            }
        }
        self.resultArray = tempArray;
    }
    else
        self.resultArray = nil;
    ;
}

- (id)init
{
    self = [super init];
    if (self) {
        _date = AllDate;
        
        @weakify(self);
        [[RACObserve(self, array) skip:0] subscribeNext:^(id x) {
            @strongify(self);
            if (x) {
                self.date = AllDate;
            }
        }];
    }
    return self;
}

- (void)addRequestParm:(NSMutableDictionary*)parameters
{
    //    [parameters setObject:self.doc_id forKey:@"tId"];
}

- (NSString*)getListUrl
{
    return API_TaskList;
}

- (id)parseItem:(NSDictionary*)dic
{
    TaskData *data = [TaskData modelWithDictionary: dic];
    return data;
}
@end
