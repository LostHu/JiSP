//
//  TaskInfoViewModel.m
//  JiSuPai
//
//  Created by Lost on 2018/1/14.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TaskInfoViewModel.h"

@implementation TaskInfoViewModel

- (NSMutableArray*)arrayPhotos
{
    if (!_arrayPhotos) {
        _arrayPhotos = [NSMutableArray new];
    }
    return _arrayPhotos;
}

- (void)postOrderPhoto:(UIImage*)img name:(NSString*)name block:(ModelCompleteBlock)block;
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setObject:self.data.pureid forKey:@"id"];
    [parameters setObject:name forKey:@"picName"];
    @weakify(self);
    [LostHttpClient POSTFileURL:API_PostOrderPhoto parameter:parameters fileList:@[img] fileName:@[name] successBlock:^(id returnValue, HttpResponseData *appendData) {
        if (appendData.flag == YES) {
            if (block) {
                block(nil,YES);
            }
        }
        else
        {
            [HUD showMsg:appendData.msg type: HUDMsgType_Error];
        }
    } progressBlock:^(CGFloat progress) {
        NSLog(@"%@", FormatStr(@"%.0f%%",progress));
    } failureBlock:^{
        
    }];
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

@end
