//
//  LostTimer.h
//  Football
//
//  Created by Lost on 15/7/22.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <Foundation/Foundation.h>

// 天-年
#define  aMinute    60.0
#define  anHour     (aMinute * 60.0)
#define  aDay       (anHour * 24.0)
#define  aMonth     (aDay * 30.0)
#define  aYear      (aMonth * 12.0)

@interface LostTimer : NSObject

// 几时几分 HH:SS
+ (NSString *)parseCnTime:(double)timestamp;
+ (NSString *)parseTime:(double)timestamp;
// 年月日 yyyy-MM-dd
+ (NSString *)parseDate:(double)timestamp;
+ (NSString *)parseCnDate:(double)timestamp;
// 日期+时间
+ (NSString *)parseDateTime:(double)timestamp;
+ (NSString *)parseCnDateTime:(double)timestamp;

#pragma mark -- 基础接口
//  获取时间，自定义格式
+ (NSString*)parseDate:(double)timestamp withFormat:(NSString *)format;
+ (double)parseDate:(double)timestamp offset:(double)offset;

+ (NSString *)parseSinceNowTime:(double)timestamp;

//通过时间间隔来转换成 时分秒
+ (NSString *)parseTimeInterval:(double)timestamp;

//时间戳转换为年龄
+ (NSString *)parseSinceNowToYearOld:(double)timestamp;
// 周几
+ (NSString *)weekdayStringFromDate:(NSDate*)inputDate;

// 是否是同一个月
+ (BOOL)isSameMonth4Math:(NSDate*)aDate otherDate:(NSDate*)bDate;

//是否为同一天 方法一
+ (BOOL)isSameToday4Math:(NSDate*)newDate;
+ (BOOL)isSameDay4Math:(NSDate*)aDate otherDay:(NSDate*)bDate;

//是否为同一天 方法2
+ (BOOL)isSameToday:(NSDate*)newDate;
+ (BOOL)isSameDay:(NSDate *)aDate otherDay:(NSDate*)bDate;

@end
