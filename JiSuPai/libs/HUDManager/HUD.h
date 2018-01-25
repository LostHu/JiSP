//
//  HUDMsgManager.h
//  Lust
//
//  Created by Lost on 16/3/30.
//  Copyright © 2016年 Lost. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HUDMsgType)
{
    HUDMsgType_Normal      = 1,    // 普通，不带图标，菊花或者文字
    HUDMsgType_Error       = 2,    // 错误
    HUDMsgType_Success     = 3,    // 成功
    HUDMsgType_Warning     = 4,    // 警告
};

@interface HUD : NSObject
+ (void)showLoading;
+ (void)showMsg:(NSString*)msg type:(HUDMsgType)type;
+ (void)showMsg:(NSString*)msg;
+ (void)hideView;
@end
