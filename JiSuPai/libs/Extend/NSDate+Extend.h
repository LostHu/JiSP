//
//  NSDate+Extend.h
//  GameBiBi
//
//  Created by Lost on 2017/11/6.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extend)
@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger nanosecond;

@property (nonatomic, readonly) NSInteger weekday;
@property (nonatomic, readonly) NSInteger weekOfMonth; ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger weekOfYear; ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger yearForWeekOfYear; // 一般配合weekOfYear使用
@property (nonatomic, readonly) NSInteger quarter;      // 季度

@property (nonatomic, readonly) BOOL isLeapMonth; ///< whether the month is leap month
@property (nonatomic, readonly) BOOL isLeapYear; ///< whether the year is leap year
@property (nonatomic, readonly) BOOL isToday; ///< whether date is today (based on current locale)
@property (nonatomic, readonly) BOOL isYesterday; ///< whether date is yesterday (based on current
@property (nonatomic, readonly) BOOL isTomorrow; ///< whether date is yesterday (based on current


- (nullable NSDate *)dateByAddingYears:(NSInteger)years;
- (nullable NSDate *)dateByAddingMonths:(NSInteger)months;
- (nullable NSDate *)dateByAddingWeeks:(NSInteger)weeks;
- (nullable NSDate *)dateByAddingDays:(NSInteger)days;
- (nullable NSDate *)dateByAddingHours:(NSInteger)hours;
- (nullable NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (nullable NSDate *)dateByAddingSeconds:(NSInteger)seconds;

- (nullable NSString *)format:(NSString *_Nonnull)format;
+ (nullable NSDateFormatter *)ISOFormat;
+ (nullable NSDate *)dateWithTimeStamp:(double)timeStamp;
+ (nullable NSDate *)dateWithString:(NSString *_Nonnull)dateString format:(NSString *_Nonnull)format;
@end




