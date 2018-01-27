//
//  FreeTimeViewModel.m
//  JiSuPai
//
//  Created by Lost on 2018/1/21.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "FreeTimeViewModel.h"

@implementation FreeTimeViewModel

- (id)init
{
    self = [super init];
    if (self) {
        _startDate = [NSDate date];
        _endDate = [_startDate dateByAddingMonths:2];
    }
    return self;
}

- (void)addFreeTime:(ModelCompleteBlock)block
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[self.startDate format:@"yyyy-MM-dd"] forKey:@"startdate"];
    [parameters setObject:[self.endDate format:@"yyyy-MM-dd"] forKey:@"enddate"];
    [parameters setObject:self.startTime forKey:@"starttime"];
    [parameters setObject:self.endTime forKey:@"endtime"];
    
    [LostHttpClient GETRequestURL:API_AddFreeTime WithParameter:parameters
             WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
                 
             }
                 WithFailureBlock:^{
                     
                 }];
}

- (NSArray*)arrayHour
{
    NSMutableArray* array = [NSMutableArray new];
    for (int i = 0; i<24; i++) {
        [array addObject:FormatStr(@"%02d",i)];
    }
    return [NSArray arrayWithArray:array];
}

- (NSArray*)arrayMin
{
    return @[@"00",@"30"];
}

- (void)addRequestParm:(NSMutableDictionary*)parameters
{
    //    [parameters setObject:self.doc_id forKey:@"tId"];
}

- (NSString*)getListUrl
{
    return API_FreeList;
}

- (id)parseItem:(NSDictionary*)dic
{
    FreeTimeData *data = [FreeTimeData modelWithDictionary: dic];
    return data;
}
@end
