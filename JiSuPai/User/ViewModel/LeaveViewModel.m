//
//  LeaveViewModel.m
//  JiSuPai
//
//  Created by Lost on 2018/1/26.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "LeaveViewModel.h"

@implementation LeaveViewModel

- (id)init
{
    self = [super init];
    if (self) {
        _startDate = [NSDate date];
        _endDate = [_startDate dateByAddingDays:3];
    }
    return self;
}

- (void)addLeave:(ModelCompleteBlock)block
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[self.startDate format:@"yyyy-MM-dd"] forKey:@"startdate"];
    [parameters setObject:[self.endDate format:@"yyyy-MM-dd"] forKey:@"enddate"];
    if (![NSString isBlankString:self.descrip]) {
        [parameters setObject:self.descrip forKey:@"descrip"];
    }
    
    [LostHttpClient GETRequestURL:API_AddLeaveTime WithParameter:parameters
             WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
                 if (appendData.flag == YES) {
                     if (block) {
                         block(nil,YES);
                     }
                 }
                 else
                 {
                     [HUD showMsg:appendData.msg type: HUDMsgType_Error];
                 }
    }
                 WithFailureBlock:^{
        
    }];
}

- (void)delLeave:(LeaveData*)data block:(ModelCompleteBlock)block
{
    if (!data) {
        return;
    }
    
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(data.leaveId) forKey:@"id"];
    
    [LostHttpClient GETRequestURL:API_DeleteLeaveTime WithParameter:parameters
             WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
                 if (appendData.flag == YES) {
                     if (block) {
                         block(nil,YES);
                     }
                 }
                 else
                 {
                     [HUD showMsg:appendData.msg type: HUDMsgType_Error];
                 }
             }
                 WithFailureBlock:^{
                     
                 }];
}

- (void)addRequestParm:(NSMutableDictionary*)parameters
{
}

- (NSString*)getListUrl
{
    return API_LeaveList;
}

- (id)parseItem:(NSDictionary*)dic
{
    LeaveData *data = [LeaveData modelWithDictionary: dic];
    return data;
}
@end
