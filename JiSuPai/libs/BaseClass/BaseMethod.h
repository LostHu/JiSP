//
//  BaseMethod.h
//  RealTimeNews
//
//  Created by MAC on 14-7-25.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TowWorldsLength = 0,
    ThreeWorldsLength = 1
} WeekContentType;

@interface BaseMethod : NSObject

#pragma mark ==================================
#pragma mark ==  label高度方法
/**
 *  label高度方法
 *
 *  @param value    字符串
 *  @param fontSize label-font size
 *  @param width    label宽度
 *
 *  @return size
 */
+ (CGSize) getSizeheightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
/**
 *  label高度方法
 *
 *  @param value 字符串
 *  @param font  font
 *  @param width label宽度
 *
 *  @return label高度
 */
+ (float) getHeightForString:(NSString *)value font:(UIFont *)font andWidth:(float)width;

#pragma mark ==================================
#pragma mark ==  时间方法

#pragma mark - date 转换 类似：@"YYYY-MM-dd"  格式字符串
/**
 *  date 转换 类似：@"YYYY-MM-dd"  格式字符串
 *
 *  @param date       NSDate 类型数据
 *  @param dateFormat @"YYYY-MM-dd" 格式
 *
 *  @return 类似：@"YYYY-MM-dd"  格式字符串
 */
+ (NSString *)dateModeChangeToString:(NSDate *)date withDateFormat:(NSString *)dateFormat;

#pragma mark - 根据date类型返回上一个月或者上一周类似的  时间戳
/**
 *  根据date类型返回上一个月或者上一周类似的  时间戳
 *
 *  @param date        NSDate 类型数据
 *  @param monthNumber -1或者+1  依次类推
 *  @param weekNumber  -1或者+1  依次类推
 *
 *  @return 时间戳string
 */
+ (NSString *) coumperMouth:(NSDate *)date andMouthNumber:(NSInteger )monthNumber andWeekNumber:(NSInteger )weekNumber;

#pragma mark - date 转换 时间戳
/**
 *  date 转换 时间戳
 *
 *  @param date NSDate 类型数据
 *
 *  @return 时间戳string
 */
+ (NSString *) dateModeChangeToTimestamp:(NSDate *)date;

#pragma mark - 时间戳  转换  date
/**
 *  时间戳  转换  date
 *
 *  @param timestamp 时间戳string
 *
 *  @return NSDate 类型数据
 */
+ (NSDate *)timestampModeChangeToDate:(NSString *)timestamp;

#pragma mark - 时间戳 转换  类似：@"YYYY-MM-dd"  格式字符串
/**
 *  时间戳 转换  类似：@"YYYY-MM-dd"  格式字符串
 *
 *  @param timestamp  时间戳string
 *  @param dateFormat @"YYYY-MM-dd"  格式
 *
 *  @return 类似：@"YYYY-MM-dd"  格式字符串
 */
+ (NSString *)timestampModeChangeToString:(NSString *)timestamp withDateFormat:(NSString *)dateFormat;

#pragma mark - 根据 date 返回当前date 的 月份
/**
 *  根据 date 返回当前date 的 月份
 *
 *  @param date NSDate 类型数据
 *
 *  @return 月份String
 */
+ (NSString *)monthOfDate:(NSDate *)date;

#pragma mark - 根据 date 返回当前date 的 星期
@property (nonatomic, assign) WeekContentType weekType; // 类型
/**
 *  根据 date 返回当前date 的 星期
 *
 *  @param date     NSDate 类型数据
 *  @param weekType WeekContentType
 *
 *  @return 星期String
 */
+ (NSString *)weekOfDate:(NSDate *)date with:(WeekContentType )weekType;

#pragma mark -  根据时间戳计算距当前时间差
/**
 *  根据时间戳计算距当前时间差
 *
 *  @param timeStamp 时间戳string
 *
 *  @return 类似于10天前String
 */
+ (NSString *)CalculateAccordingToTheTimeStampFromTheCurrentTime:(NSString *)timeStamp;

#pragma mark -  根据 date 字符串 类似“yyyy-MM-dd” 转换 date格式
/**
 *  根据 date 字符串 类似“yyyy-MM-dd” 转换 date格式
 *
 *  @param dateStr    类似“yyyy-MM-dd” String
 *  @param dateFormat 类似“yyyy-MM-dd” 格式
 *
 *  @return NSDate 数据类型
 */
+ (NSDate *)dateStrModeChangeToDateMode:(NSString *)dateStr withDateFormat:(NSString *)dateFormat;

#pragma mark -判断字符串中是否还有表情
/**
 *  判断字符串中是否还有表情
 *
 *  @param string 需要判断的String
 *
 *  @return bool
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

#pragma mark -判断是否Null值
/**
 *  判断是否Null值
 *
 *  @param obj id 对象
 *
 *  @return String
 */
+ (NSString *)isNull:(id)obj;

#pragma mark -解析schema协议
+ (NSMutableDictionary *)parseTheSchemaAgreementWithString:(NSString *)string;

#pragma mark - 内联函数把@“#ff3344”转成UIColor
/**
 *  内联函数把@“#ff3344”转成UIColor
 *
 *  @param str @“#ff3344”  String
 *
 *  @return UIColor
 */
+ (UIColor *) stringTOColor:(NSString *)str;

#pragma mark - 身份证识别
/**
 *  身份证识别
 *
 *  @param cardNo 号码
 *
 *  @return bool
 */
+ (BOOL)checkIdentityCardNo:(NSString*)cardNo;

#pragma mark - 银行卡校验
/**
 *  银行卡校验
 *
 *  @param cardNo 号码
 *
 *  @return bool
 */
+ (BOOL)checkCardNo:(NSString*) cardNo;

#pragma mark - AttributedString
/**
 *  AttributedString
 *
 *  @param str         String
 *  @param lineSpacing 行间距
 *  @param fond        字体
 *  @param color       颜色
 *
 *  @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)setAttributedStringStr:(NSString *)str lineSpacing:(CGFloat )lineSpacing fond:(UIFont *)fond color:(UIColor *)color;

#pragma mark - 检测是否是手机号码
/**
 *  检测是否是手机号码
 *
 *  @param mobileNum 号码
 *
 *  @return bool
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  删除线
 *
 *  @param string <#string description#>
 *  @param font   <#font description#>
 *  @param color  <#color description#>
 *
 *  @return <#return value description#>
 */
+ (NSMutableAttributedString *)setStrikethroughAttributedStringWithString:(NSString *)string font:(UIFont *)font colr:(UIColor *)color;

#pragma mark - uiclolr -->  uiimage
+ (UIImage *)createImageWithColor:(UIColor *)color;

+ (NSDictionary *)parseURLParams:(NSString *)query;
@end
