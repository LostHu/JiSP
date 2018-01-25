//
//  LevelManager.m
//  GameBiBi
//
//  Created by Lost on 2017/7/27.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import "LevelManager.h"

#define MAX_LEVEL 7
#define LEVEL_GAP 5

@interface LevelManager()
@property (nonatomic, strong) NSArray* arrayMyLevelTitle;
@end

@implementation LevelManager

+(NSString *)toRoman:(NSInteger)num {
    NSString *roman = @"";
    if (num > 0 && num < 100) {
        
        NSArray *pChars = [[NSArray alloc]initWithObjects: @"L", @"X", @"V", @"I", nil];
        NSArray *pValues = [[NSArray alloc]initWithObjects:@"50",@"10" , @"5", @"1" , nil];
        
        
        while (num > 0) {
            if (num >= 90) {
                roman = [roman stringByAppendingString:@"XC"];
                num -= 90;
                continue;
            }
            
            if (num >= [[pValues objectAtIndex:0] intValue]) {
                NSString *string = [NSString stringWithFormat:@"%@",[pChars objectAtIndex:0]];
                roman = [roman stringByAppendingString:string];
                num -= [[pValues objectAtIndex:0] intValue];
                continue;
            }
            if (num >= 40) {
                roman = [roman stringByAppendingString:@"XL"];
                
                num -= 90;
                continue;
            }
            if (num >= [[pValues objectAtIndex:1] intValue]) {
                int x10 = (int)num /[[pValues objectAtIndex:1] intValue];
                for (int i = 0; i < x10; i++) {
                    
                    NSString *string = [NSString stringWithFormat:@"%@",[pChars objectAtIndex:1]];
                    roman = [roman stringByAppendingString:string];
                    num -= [[pValues objectAtIndex:1] intValue];
                }
                continue;
            }
            if (num >= 9) {
                roman = [roman stringByAppendingString:@"IX"];
                
                num -= 9;
                continue;
            }
            if (num >= [[pValues objectAtIndex:2] intValue]) {
                
                NSString *string = [NSString stringWithFormat:@"%@",[pChars objectAtIndex:2]];
                roman = [roman stringByAppendingString:string];
                
                num -= [[pValues objectAtIndex:2] intValue];
                continue;
            }
            if (num == 4) {
                roman = [roman stringByAppendingString:@"IV"];
                num = 0;
                continue;
            }
            for (int i = 0; i < num; i++) {
                
                NSString *string = [NSString stringWithFormat:@"%@",[pChars objectAtIndex:3]];
                roman = [roman stringByAppendingString:string];
                
                num -= [[pValues objectAtIndex:3] intValue];
            }
        }
        
        
    } else {
        NSLog(@"数字超出范围！");
    }
    
    return roman;  
}

+ (NSArray*)myLevelTitle
{
    return [NSArray arrayWithObjects:@"黑铁",@"青铜",@"白银",@"黄金",@"铂金",@"钻石",@"王者", nil];
}
+ (NSArray*)myLevelImgPre
{
    return [NSArray arrayWithObjects:@"iron",@"bronze",@"silver",@"gold",@"Platinum",@"masonry",@"King", nil];
}

+ (NSArray*)userLevelImgPre
{
    return [NSArray arrayWithObjects:@"medal_ht",@"medal_qt",@"medal_by",@"medal_hj",@"medal_bj",@"medal_zs",@"medal_wz", nil];
}

+ (NSString*)getUserLevelLogo:(NSInteger)level
{
    if (level > MAX_LEVEL*LEVEL_GAP || level <= 0) {
        level = 1;
    }
    NSInteger max_level = ((CGFloat)ceil(level*1.0/LEVEL_GAP))-1;
    NSInteger min_level =  LEVEL_GAP - ((level -1) %LEVEL_GAP);
    
    max_level = max_level > [[LevelManager userLevelImgPre] count]-1 ? [[LevelManager userLevelImgPre] count]-1 : max_level;
    min_level = min_level > LEVEL_GAP ? LEVEL_GAP : min_level;
    NSString* pre = [[LevelManager userLevelImgPre] objectAtIndex:max_level];
    NSString* result = [NSString stringWithFormat:@"%@%ld",pre,min_level];
    return result;
}

+ (NSString*)getMyLevelLogo:(NSInteger)level
{
    if (level > MAX_LEVEL*LEVEL_GAP || level <= 0) {
        return @"?";
        level = 1;
    }
    NSInteger max_level = ((CGFloat)ceil(level*1.0/LEVEL_GAP))-1;
    NSInteger min_level = LEVEL_GAP - ((level -1) %LEVEL_GAP);
    max_level = max_level > [[LevelManager myLevelImgPre] count]-1 ? [[LevelManager myLevelImgPre] count]-1 : max_level;
    min_level = min_level > LEVEL_GAP ? LEVEL_GAP : min_level;
    NSString* pre = [[LevelManager myLevelImgPre] objectAtIndex:max_level];
    NSString* result = FormatStr(@"%@_%ld",pre,min_level);
    
    return result;
}

+ (NSString*)getMyLevelName:(NSInteger)level
{
    if (level > MAX_LEVEL*LEVEL_GAP || level <= 0) {
        return @"敬请期待";
    }
    NSInteger max_level = ((CGFloat)ceil(level*1.0/LEVEL_GAP))-1;
    NSInteger min_level = LEVEL_GAP - ((level -1) %LEVEL_GAP);
    max_level = max_level > [[LevelManager myLevelImgPre] count]-1 ? [[LevelManager myLevelImgPre] count]-1 : max_level;
    min_level = min_level > LEVEL_GAP ? LEVEL_GAP : min_level;
    NSString* pre = [[LevelManager myLevelTitle] objectAtIndex:max_level];
    NSString* result = FormatStr(@"%@%@",pre,[LevelManager toRoman:min_level]);
    
    return result;
}

@end
