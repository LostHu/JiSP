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
    
    MAIN((^{
        NSMutableString * phoneStr = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
        NSURL *phoneUrl = [NSURL URLWithString:phoneStr];
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        }
    }));
//    dispatch_async(dispatch_get_main_queue(0, 0), ^{
//        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
//            [[UIApplication sharedApplication] openURL:phoneUrl];
//        }
//    });
}

@end
