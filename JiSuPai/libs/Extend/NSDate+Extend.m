//
//  NSDate+Extend.m
//  GameBiBi
//
//  Created by Lost on 2017/11/6.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import "NSDate+Extend.h"

@implementation NSDate (Extend)


- (NSInteger)year
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)quarter
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (NSInteger)month
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitNanosecond fromDate:self] nanosecond];
}

- (NSInteger)weekday
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekOfMonth
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (BOOL)isLeapMonth
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

- (BOOL)isLeapYear
{
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

- (BOOL)isToday
{
    if (fabs(self.timeIntervalSinceNow) >= 60*60*24) {
        return NO;
    }
    return self.day == [NSDate date].day;
}

- (BOOL)isYesterday
{
    // 将目标日期+1天，判定和今天是否同一天，以此判定是否是昨天
    NSDate* newDate = [self dateByAddingDays:1];
    return [newDate isToday];
}

- (BOOL)isTomorrow
{
    // 同上
    NSDate* newDate = [self dateByAddingDays:-1];
    return [newDate isToday];
}

- (nullable NSDate*)dateByAddingYears:(NSInteger)years
{
    NSDateComponents* components = [NSDateComponents new];
    [components  setYear:years];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (nullable NSDate*)dateByAddingMonths:(NSInteger)months
{
    NSDateComponents* components = [NSDateComponents new];
    [components  setMonth:months];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (nullable NSDate *)dateByAddingWeeks:(NSInteger)weeks
{
    NSDateComponents* components = [NSDateComponents new];
    [components  setWeekOfYear:weeks];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (nullable NSDate *)dateByAddingDays:(NSInteger)days
{
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate]+days*60*60*24;
    NSDate* newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
    return newDate;
}

- (nullable NSDate *)dateByAddingHours:(NSInteger)hours
{
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate]+hours*60*60;
    NSDate* newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
    return newDate;
}

- (nullable NSDate *)dateByAddingMinutes:(NSInteger)minutes
{
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate]+minutes*60;
    NSDate* newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
    return newDate;
}

- (nullable NSDate *)dateByAddingSeconds:(NSInteger)seconds
{
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate]+seconds;
    NSDate* newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
    return newDate;
}

- (NSString *)format:(NSString *)format {
    NSDateFormatter *formatter = [NSDate ISOFormat];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

+ (NSDateFormatter *)ISOFormat {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    });
    return formatter;
}

+ (NSDate*)dateWithTimeStamp:(double)timeStamp
{
    return [NSDate dateWithTimeIntervalSince1970:timeStamp];
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format{
    
    [[self ISOFormat] setDateFormat: format];
    NSDate *destDate= [[self ISOFormat] dateFromString:dateString];
    
    return destDate;
}

@end








