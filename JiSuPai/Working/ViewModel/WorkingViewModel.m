//
//  WorkingViewModel.m
//  JiSuPai
//
//  Created by Lost on 2018/1/28.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "WorkingViewModel.h"

@implementation WorkingViewModel

- (void)getWorkingData:(ModelCompleteBlock)block
{
    NSMutableDictionary* parameters = [NSMutableDictionary new];
    [LostHttpClient GETRequestURL:API_WorkingTask WithParameter:parameters WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
        if (returnValue[@"rows"]) {
            self.data = [TaskData modelWithDictionary:returnValue[@"rows"]];
        }else{
            [HUD showMsg:appendData.msg type: HUDMsgType_Error];
        }
        if (block) {
            block(nil,YES);
        }
    } WithFailureBlock:^{
        
    }];
}

@end
