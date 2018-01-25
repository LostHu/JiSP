//
//  PhotoThumbSvr.m
//  GameBiBi
//
//  Created by Lost on 2017/8/23.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import "PhotoThumbSvr.h"

@implementation PhotoThumbSvr
+ (NSString*)url:(NSString*)url ruleForW:(NSInteger)w H:(NSInteger)h
{
    if ([NSString isBlankString:url]) {
        return nil;
    }
    NSMutableString* targetUrl = [NSMutableString stringWithString:url];
//    [targetUrl appendString:[url stringByReplacingOccurrencesOfString:@"oss-cn" withString:@"img-cn"]];
    if ( w > 1 && h > 1 && w <= 4096 && h <= 4096) {
        [targetUrl appendString:[NSString stringWithFormat:@"?x-oss-process=image/resize,w_%ld,h_%ld",(long)w,(long)h]];
    }
    
    // _1wh 表示透明区域填充白色
    
//    NSLog(targetUrl);
    
    return targetUrl;
}

+ (NSString*)urlForArticleScreenshot:(NSString*)url
{
    if ([NSString isBlankString:url]) {
        return nil;
    }
    NSInteger w = 240;
    NSInteger h = 150;
    NSMutableString* targetUrl = [NSMutableString stringWithString:url];
    if ( w > 1 && h > 1 && w <= 4096 && h <= 4096) {
        [targetUrl appendString:[NSString stringWithFormat:@"?x-oss-process=image/resize,m_fill,w_%ld,h_%ld",(long)w,(long)h]];
    }
    
    return targetUrl;
}

+ (NSString*)urlForUserFace:(NSString*)url
{
    return [self url:url ruleForW:160 H:160];
}

+ (NSString*)urlForMiniUserFace:(NSString*)url
{
    return [self url:url ruleForW:80 H:80];
}

+ (NSString*)urlForGameLogo:(NSString*)url
{
    return [self url:url ruleForW:160 H:160];
}

+ (NSString*)urlForGameMiniLogo:(NSString*)url
{
    return [self url:url ruleForW:80 H:80];
}

+ (NSString*)urlForGameBg:(NSString*)url
{
    return url;
    //    CGFloat width = SCREEN_WIDTH-20-30;
    //    return [self url:url ruleForW:width*2 H:360];
}

@end
