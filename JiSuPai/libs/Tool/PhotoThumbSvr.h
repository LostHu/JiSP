//
//  PhotoThumbSvr.h
//  GameBiBi
//
//  Created by Lost on 2017/8/23.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PhotoThumbSvr(imgURL,imgW,imgH)    [PhotoThumbSvr url:imgURL ruleForW:imgW H:imgH]

@interface PhotoThumbSvr : NSObject
+ (NSString*)url:(NSString*)url ruleForW:(NSInteger)w H:(NSInteger)h;

+ (NSString*)urlForArticleScreenshot:(NSString*)url;
+ (NSString*)urlForUserFace:(NSString*)url;
+ (NSString*)urlForMiniUserFace:(NSString*)url;
+ (NSString*)urlForGameLogo:(NSString*)url;
+ (NSString*)urlForGameMiniLogo:(NSString*)url;
+ (NSString*)urlForGameBg:(NSString*)url;
@end
