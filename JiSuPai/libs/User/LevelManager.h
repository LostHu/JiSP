//
//  LevelManager.h
//  GameBiBi
//
//  Created by Lost on 2017/7/27.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelManager : NSObject
+ (NSString*)getMyLevelLogo:(NSInteger)level;
+ (NSString*)getMyLevelName:(NSInteger)level;
+ (NSString*)getUserLevelLogo:(NSInteger)level;
@end
