//
//  HUDMsgManager.m
//  Lust
//
//  Created by Lost on 16/3/30.
//  Copyright © 2016年 Lost. All rights reserved.
//

#import "HUD.h"

@implementation HUD
+ (void)showLoading
{
    [self showMsg:nil type:HUDMsgType_Normal];
}

+ (void)showMsg:(NSString*)msg type:(HUDMsgType)type
{
    if ([NSString isBlankString:msg]) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName: Notify_ShowMessage
                                                        object:self
                                                      userInfo:@{@"Type":@"Show",
                                                                 @"HUDType":@(type),
                                                                 @"Msg":msg}];
}

+ (void)showMsg:(NSString*)msg
{
    [self showMsg:msg type:HUDMsgType_Normal];
}

+ (void)hideView
{
    [[NSNotificationCenter defaultCenter] postNotificationName: Notify_ShowMessage
                                                        object:self
                                                      userInfo:@{@"Type":@"Hide"}];
}
@end
