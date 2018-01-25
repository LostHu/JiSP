//
//  TaskListViewModel.m
//  JiSuPai
//
//  Created by Lost on 2018/1/13.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TaskListViewModel.h"

@implementation TaskListViewModel

- (id)init
{
    self = [super init];
    if (self) {
        _date = [NSDate date];
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
