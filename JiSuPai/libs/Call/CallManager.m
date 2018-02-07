//
//  CallManager.m
//  JiSuPai
//
//  Created by Lost on 2018/2/7.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "CallManager.h"

@implementation CallManager

+ (void)callPhone:(NSString*)phone
{
    if ([NSString isBlankString:phone]) {
        return;
    }
    NSMutableString * phoneStr = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
    NSURL *phoneUrl = [NSURL URLWithString:phoneStr];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        }
    });
}

@end
