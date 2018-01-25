//
//  LostTimer.m
//  Football
//
//  Created by Lost on 15/7/22.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LostTimer.h"

@implementation LostTimer

+ (NSString *)parseTimeIntervalFormat:(double)origTime
{
    NSString *strRet = @"";
    
    NSTimeInterval timeOffset = origTime;
    
    if (timeOffset < 0)
        timeOffset = aDay;
    
    if (timeOffset > aDay)
    {
        strRet = [NSString stringWithFormat:@"%d", (int)(timeOffset / aDay)];
    }
    else
    {
        int hour = (int)(timeOffset/anHour);
        int minute = (int)(timeOffset - hour*3600)/aMinute;
        int second = timeOffset - hour*3600 - minute*60;
        strRet = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute,second];
    }
    return strRet;
}

+ (double)parseDate:(double)origTime offset:(double)offset
{
    return origTime + offset;
}

+ (NSString *)parseDateMMddAndWeek:(double)origTime
{
    if (origTime <= 0) {
        return @"";
    }
    
    NSString* strDate = [self parseDate:origTime];
    NSDate* thisDate = [NSDate dateWithTimeIntervalSince1970:origTime];
    NSString* week = [self weekdayStringFromDate:thisDate];
    strDate = [NSString stringWithFormat:@"%@ %@",strDate,week];
    
    return strDate;
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    return [weekdays objectAtIndex:inputDate.weekday];
}

// 获取12小时制时间，格式:10:11 上午
+ (NSString *)getFormatTime:(double)origTime
{
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:origTime];
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;
    
    comps = [calendar components:unitFlags fromDate:detaildate];
    
    NSInteger hour = [comps hour];
    NSInteger minute = [comps minute];
    
    NSString *formatTime;
    if(hour < 12)
    {
        // 上午
        if(minute<10)
            formatTime = [NSString stringWithFormat:@"%ld:0%ld 上午",(long)hour,(long)minute];
        else
            formatTime = [NSString stringWithFormat:@"%ld:%ld 上午", (long)hour,(long)minute];
    }
    else
    {
        NSInteger hourPM = hour - 12;
        if (hourPM == 0)
            hourPM = 12;
        
        // 下午
        if(minute<10)
            formatTime = [NSString stringWithFormat:@"%ld:0%ld 下午",(long)hourPM,(long)minute];
        else
            formatTime = [NSString stringWithFormat:@"%ld:%ld 下午",(long)hourPM,(long)minute];
    }
    
    return formatTime;
}

// 星座
+ (NSString *)getAstroWithTime:(double)origTime{
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:origTime];
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay;
    comps = [calendar components:unitFlags fromDate:detaildate];
    
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    
    return [self getAstroWithMonth:month day:day];
}

// 星座
+ (NSString *)getAstroWithMonth:(NSInteger)m day:(NSInteger)d{
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (m<1||m>12||d<1||d>31){
        return @"错误日期格式!";
    }
    if(m==2 && d>29)
    {
        return @"错误日期格式!!";
    }
    else if(m==4 || m==6 || m==9 || m==11) {
        if (d>30) {
            return @"错误日期格式!!!";
        }
    }
    result = [NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    return [result stringByAppendingString:@"座"];
}

+ (NSString *)parseCnTime:(double)origTime
{
    return [self parseDate:origTime withFormat:@"HH点mm分"];
}

+ (NSString *)parseTime:(double)origTime
{
    return [self parseDate:origTime withFormat:@"HH:mm"];
}

+ (NSString *)parseDate:(double)origTime
{
    return [self parseDate:origTime withFormat:@"yyyy-MM-dd"];
}

+ (NSString *)parseCnDate:(double)origTime
{
    return [self parseDate:origTime withFormat:@"yyyy年MM月dd日"];
}

+ (NSString *)parseDateTime:(double)origTime
{
    return [self parseDate:origTime withFormat:@"yyyy-MM-dd HH:mm"];
}

+ (NSString *)parseCnDateTime:(double)origTime
{
    return [self parseDate:origTime withFormat:@"yyyy年MM月dd日 HH时mm分"];
}

///
/// formatStr: eg. @"yyyy-MM-dd HH:mm"
///
+ (NSString*)parseDate:(double)origTime withFormat:(NSString *)formatStr
{
    NSDate* newDate = [NSDate dateWithTimeStamp:origTime];
    return [newDate format:formatStr];
}

+ (NSString *)parseTimeInterval:(double)origTime
{
    NSString *strRet = @"";
    
    NSTimeInterval timeOffset = origTime;
    
    if (timeOffset < 0)
        timeOffset = aDay;
    
    if (timeOffset < aMinute)
        strRet = [NSString stringWithFormat:@"%d秒", (int)timeOffset];
    else if (timeOffset < anHour)
        strRet = [NSString stringWithFormat:@"%d分钟", (int)(timeOffset / aMinute)];
    else if (timeOffset < aDay)
        strRet = [NSString stringWithFormat:@"%d个小时", (int)(timeOffset / anHour)];
    else if (timeOffset < aMonth)
        strRet = [NSString stringWithFormat:@"%d天", (int)(timeOffset / aDay)];
    else if (timeOffset < aYear)
        strRet = [NSString stringWithFormat:@"%d个月", (int)(timeOffset / aMonth)];
    else
        strRet = [NSString stringWithFormat:@"%d年", (int)(timeOffset / aYear)];
    return strRet;
}

+ (NSString *)parseSinceNowTime:(double)origTime
{
    NSString *strRet = @"";
    NSTimeInterval postTimeInterval = origTime;
    
    NSDate *postDate = [NSDate dateWithTimeStamp:postTimeInterval];
    NSDate *now = [NSDate date];
    
    NSTimeInterval timeOffset = [now timeIntervalSinceDate:postDate];
    
    if (timeOffset < 0)
        timeOffset = aDay;
    
    if (timeOffset < aMinute)
        strRet = [NSString stringWithFormat:@"%d秒", (int)timeOffset];
    else if (timeOffset < anHour)
        strRet = [NSString stringWithFormat:@"%d分钟", (int)(timeOffset / aMinute)];
    else if (timeOffset < aDay)
        strRet = [NSString stringWithFormat:@"%d小时", (int)(timeOffset / anHour)];
    else if (timeOffset < aMonth)
        strRet = [NSString stringWithFormat:@"%d天", (int)(timeOffset / aDay)];
    else if (timeOffset < aYear)
        strRet = [NSString stringWithFormat:@"%d个月", (int)(timeOffset / aMonth)];
    else
        strRet = [NSString stringWithFormat:@"%d年", (int)(timeOffset / aYear)];
        
    return strRet;
}

+ (NSString *)parseSinceNowToYearOld:(double)origTime
{
    NSString *strRet = @"";
    NSTimeInterval postTimeInterval = origTime;
    
    NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:postTimeInterval];
    NSDate *now = [NSDate date];
    
    NSTimeInterval timeOffset = [now timeIntervalSinceDate:postDate];
    timeOffset = timeOffset < 0 ? 0 : timeOffset;
    
    strRet = [NSString stringWithFormat:@"%d", (int)(timeOffset / aYear)];
    
    return strRet;
}

//+ (NSDate*)parseDate4Stamp:(double)timestamp
//{
//    return [NSDate dateWithTimeIntervalSince1970:timestamp];
//}
//
//+ (NSDate *)parseDate4String:(NSString *)dateString{
//
//    [[NSDate ISOFormat] setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
//    NSDate *destDate= [[self ISOFormat] dateFromString:dateString];
//
//    return destDate;
//}

//是否为同一天 方法一
+ (BOOL)isSameToday4Math:(NSDate*)newDate
{
    return [self isSameDay4Math:[NSDate date] otherDay:newDate];
}

+ (BOOL)isSameDay4Math:(NSDate*)aDate otherDay:(NSDate*)bDate
{
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    if (
        (int)(([aDate timeIntervalSince1970] + timezoneFix)/aDay) -
        (int)(([bDate timeIntervalSince1970] + timezoneFix)/aDay)
        == 0)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isSameMonth4Math:(NSDate*)aDate otherDate:(NSDate*)bDate
{
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    if (
        (int)(([aDate timeIntervalSince1970] + timezoneFix)/aMonth) -
        (int)(([bDate timeIntervalSince1970] + timezoneFix)/aMonth)
        == 0)
    {
        return YES;
    }
    return NO;
}

//是否为同一天 方法2
+ (BOOL)isSameToday:(NSDate*)newDate
{
    return [self isSameDay:[NSDate date] otherDay:newDate];
}

+ (BOOL)isSameDay:(NSDate *)aDate otherDay:(NSDate*)bDate
{
    if (aDate == nil || bDate == nil) return NO;
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:aDate];
    NSDate *date_a = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:bDate];
    NSDate *date_b = [cal dateFromComponents:components];
    if([date_a isEqualToDate:date_b])
        return YES;
    
    return NO;
}

@end
