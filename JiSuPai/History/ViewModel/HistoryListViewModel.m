//
//  HistoryListViewModel.m
//  JiSuPai
//
//  Created by Lost on 2018/1/19.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "HistoryListViewModel.h"

@implementation HistoryListViewModel
- (void)addRequestParm:(NSMutableDictionary*)parameters
{
    //    [parameters setObject:self.doc_id forKey:@"tId"];
}

- (NSString*)getListUrl
{
    return API_CompleteTaskList;
}

- (id)parseItem:(NSDictionary*)dic
{
    TaskData *data = [TaskData modelWithDictionary: dic];
    return data;
}
@end

@implementation HistorySubListViewModel
- (void)addRequestParm:(NSMutableDictionary*)parameters
{
        [parameters setObject:self.taskData.firstorderid forKey:@"firstorderid"];
}

- (NSString*)getListUrl
{
    return API_CompleteSubTaskList;
}

- (id)parseItem:(NSDictionary*)dic
{
    TaskData *data = [TaskData modelWithDictionary: dic];
    return data;
}
@end
