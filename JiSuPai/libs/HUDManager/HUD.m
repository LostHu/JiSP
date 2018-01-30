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
    UIView* showInView = [YZRoutes topViewController].view;
    // 隐藏
    {
        if ([NSString isBlankString:msg] && type == HUDMsgType_Normal) {
            // 菊花
            [MBProgressHUD showHUDAddedTo:showInView animated:YES];
        }
        else
        {
            // 有文字
            switch (type) {
                case HUDMsgType_Normal:
                    [MBProgressHUD showMessage:msg view:showInView];
                    break;
                case HUDMsgType_Error:
                    [MBProgressHUD showError:msg toView:showInView];
                    break;
                case HUDMsgType_Success:
                    [MBProgressHUD showSuccess:msg toView:showInView];
                    break;
                case HUDMsgType_Warning:
                    [MBProgressHUD showWarning:msg toView:showInView];
                    break;
                default:
                    break;
            }
        }
    }
    //    [[NSNotificationCenter defaultCenter] postNotificationName: Notify_ShowMessage
    //                                                        object:self
    //                                                      userInfo:@{@"Type":@"Show",
    //                                                                 @"HUDType":@(type),
    //                                                                 @"Msg":msg}];
}

+ (void)showMsg:(NSString*)msg
{
    [self showMsg:msg type:HUDMsgType_Normal];
}

+ (void)hideView
{
    UIView* showInView = [YZRoutes topViewController].view;
    // 隐藏
    [MBProgressHUD hideAllHUDsForView:showInView animated:YES];
    //    [[NSNotificationCenter defaultCenter] postNotificationName: Notify_ShowMessage
    //                                                        object:self
    //                                                      userInfo:@{@"Type":@"Hide"}];
}
@end
