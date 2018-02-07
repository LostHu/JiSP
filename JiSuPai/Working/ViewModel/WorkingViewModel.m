//
//  WorkingViewModel.m
//  JiSuPai
//
//  Created by Lost on 2018/1/28.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "WorkingViewModel.h"

@implementation WorkingViewModel

- (id)init
{
    self = [super init];
    if (self) {
        _arrayException = [NSMutableArray new];
    }
    return self;
}

- (NSMutableArray*)arrayPhotos
{
    if (!_arrayPhotos) {
        _arrayPhotos = [NSMutableArray new];
    }
    return _arrayPhotos;
}

- (void)getOrderPhoto:(ModelCompleteBlock)block
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setObject:self.data.pureid forKey:@"id"];
    @weakify(self);
    [LostHttpClient GETRequestURL:API_GetOrderPhoto WithParameter:parameters
             WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
                 @strongify(self);
                 if (appendData.flag == YES) {
                     NSMutableArray* tempArray = [NSMutableArray new];
                     for (NSString* url in returnValue[@"data"]) {
                         NSLog(@"%@",url);
                         NSString* tempurl = [url stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
                         NSString* full_url = FormatStr(@"%@%@",AppBaseUrl,tempurl);
                         [tempArray addObject:full_url];
                     }
                     self.arrayPhotos = tempArray;
                 }
                 else
                 {
                     [HUD showMsg:appendData.msg type: HUDMsgType_Error];
                 }
             }
                 WithFailureBlock:^{
                     
                 }];
}

- (void)addWorkingExceptionType:(NSString*)type desc:(NSString*)desc block:(ModelCompleteBlock)block
{
    NSMutableDictionary* parameters = [NSMutableDictionary new];
    [parameters setObject:self.data.firstorderid forKey:@"orderid"];
    [parameters setObject:type forKey:@"title"];
    if (![NSString isBlankString:desc]) {
        [parameters setObject:desc forKey:@"descrip"];
    }
    
    [LostHttpClient GETRequestURL:API_PostWorkingException WithParameter:parameters WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
        if (returnValue) {
            if (appendData.flag == YES) {
                if (block) {
                    block(nil,YES);
                    return;
                }
            }
        }else{
            [HUD showMsg:appendData.msg type: HUDMsgType_Error];
        }
        if (block) {
            block(nil,YES);
        }
    } WithFailureBlock:^{
        
    }];
}

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

- (void)getWorkingExceptionData:(ModelCompleteBlock)block
{
    NSMutableDictionary* parameters = [NSMutableDictionary new];
    [LostHttpClient GETRequestURL:API_WorkingExceptionList WithParameter:parameters WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
        if (returnValue && [returnValue isKindOfClass:[NSDictionary class]]) {
            NSDictionary* dic = returnValue;
            [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                NSLog(@"%@ %@",key, obj);
                
//                NSDictionary* newData = @{key:obj};
                [_arrayException addObject:obj];
                
            }];
            
//            self.data = [TaskData modelWithDictionary:returnValue[@"rows"]];
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
