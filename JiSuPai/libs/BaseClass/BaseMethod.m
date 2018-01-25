//
//  BaseMethod.m
//  RealTimeNews
//
//  Created by MAC on 14-7-25.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "BaseMethod.h"

@implementation BaseMethod

+ (float) getHeightForString:(NSString *)value font:(UIFont *)font andWidth:(float)width
{
    CGSize size = [self getSizeheightForString: value font: font andWidth:width];
    return size.height;
}

+ (CGSize) getSizeheightForString:(NSString *)value font:(UIFont *)font andWidth:(float)width
{
    CGSize size;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    size = [value boundingRectWithSize:CGSizeMake(width, 0)
                               options: NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading
                            attributes:attribute
                               context:nil].size;
    return size;
}


+ (CGSize) getSizeheightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize size;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    size = [value boundingRectWithSize:CGSizeMake(width, 0)
                               options: NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading
                            attributes:attribute
                               context:nil].size;
    return size;
}


#pragma mark - date 转换 类似：@"YYYY-MM-dd"  格式字符串
+ (NSString *)dateModeChangeToString:(NSDate *)date withDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];  // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制  类似：@"YYYY-MM-dd"
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

#pragma mark - 根据date类型返回上一个月或者上一周类似的  时间戳
+ (NSString *) coumperMouth:(NSDate *)date andMouthNumber:(NSInteger )monthNumber andWeekNumber:(NSInteger )weekNumber
{
    // monthNumber = -1或者+1  依次类推
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *comps = nil;
//    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:monthNumber];
    [adcomps setDay:weekNumber];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[newdate timeIntervalSince1970]];  //  date转时间戳
    
    return timeSp;
}

#pragma mark - date 转换 时间戳
+ (NSString *) dateModeChangeToTimestamp:(NSDate *)date
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}

#pragma mark - 时间戳  转换  date
+ (NSDate *)timestampModeChangeToDate:(NSString *)timestamp
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timestamp intValue]];
    return confromTimesp;
}

#pragma mark - 时间戳 转换  类似：@"YYYY-MM-dd"  格式字符串
+ (NSString *)timestampModeChangeToString:(NSString *)timestamp withDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormat]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制  类似：@"YYYY-MM-dd"
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timestamp intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

#pragma mark - 根据 date 返回当前date 的 月份
+ (NSString *)monthOfDate:(NSDate *)date
{
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    
    NSInteger monthDay = comps.month;    
    
    NSArray *monthArray = [NSArray arrayWithObjects:@"",@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
    
    return [NSString stringWithFormat:@"%@",monthArray[monthDay]];
    
}

#pragma mark - 根据 date 返回当前date 的 星期
+ (NSString *)weekOfDate:(NSDate *)date with:(WeekContentType )weekType
{
    if (date == nil) {
        date = [NSDate date];
    }
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    NSInteger weekday = comps.weekday;
    
    NSArray *weekArray = nil;
    if (weekType == TowWorldsLength){
        weekArray = [NSArray arrayWithObjects:@"",@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    }else if (weekType == ThreeWorldsLength){
        weekArray = [NSArray arrayWithObjects:@"",@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    }
    
    NSString *weekStr = weekArray[weekday];
    
    return weekStr;
}

#pragma mark -  根据 时间戳 计算距当前时间差
+ (NSString *)CalculateAccordingToTheTimeStampFromTheCurrentTime:(NSString *)timeStamp
{
    NSDate *datenow = [NSDate date];
    long nowTimeLong = (long)[datenow timeIntervalSince1970];
    
    long createTimeLong = (long)[timeStamp longLongValue];
    long timeLong = nowTimeLong - createTimeLong;
    
    if (timeLong > 60 * 60 * 24 * 10){
        return [self timestampModeChangeToString:timeStamp withDateFormat:@"yyyy-MM-dd"];
        return @"10天前";
    }else if (timeLong > 60 * 60 * 24){
        long showString = timeLong / (60 * 60 * 24);
        return [NSString stringWithFormat:@"%ld天前",showString];
    }else if (timeLong > 60 * 60){
        long showString = timeLong / 3600;
        return [NSString stringWithFormat:@"%ld小时前",showString];
    }else if (timeLong > 60 * 5){
        long showString = timeLong / 60;
        return [NSString stringWithFormat:@"%ld分钟前",showString];
    }else{
        return @"刚刚";
    }
}

#pragma mark -  根据 date 字符串 类似“yyyy-MM-dd” 转换 date格式
+ (NSDate *)dateStrModeChangeToDateMode:(NSString *)dateStr withDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

#pragma mark -判断字符串中是否还有表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

#pragma mark -判断是否Null值
+ (NSString *)isNull:(id)obj
{
    NSString *str = @"";
    if (![obj isKindOfClass:[NSNull class]]){
        str = [NSString stringWithFormat:@"%@",obj];
    }
    return str;
}

#pragma mark - 身份证识别
+ (BOOL)checkIdentityCardNo:(NSString*)cardNo
{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}

#pragma mark - 银行卡校验
+ (BOOL)checkCardNo:(NSString*) cardNo
{
    int oddsum = 0;
    int evensum = 0;
    int allsum = 0;
    for (int i = 0; i< [cardNo length];i++)
    {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i, 1)];
        int tmpVal = [tmpString intValue];
        if((i % 2) == 0)
        {
            tmpVal *= 2;
            if(tmpVal>=10)
                tmpVal -= 9;
            evensum += tmpVal;
        }
        else
        {
            oddsum += tmpVal;
        }
    }
    allsum = oddsum + evensum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

///// 手机号码的有效性判断
#pragma mark - 检测是否是手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


//2. 跳转到文章详情页： cailianshe://article_detail?article_id=xxx
//3. 跳转到板块详情页： cailianshe://industry_detail?industry_id=xxxx
#pragma mark -解析schema协议
+ (NSMutableDictionary *)parseTheSchemaAgreementWithString:(NSString *)string
{
    NSMutableDictionary *tagDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    NSString *appUrlHead = @"cailianshe://";
    NSString *article_detail = @"article_detail";
    NSString *industry_detail = @"industry_detail";
    NSString *struggle = @"?";
    NSString *separator = @"&";
    NSString *dengyuhao = @"=";
    
    if ([string rangeOfString:appUrlHead].location != NSNotFound)
    {
        NSRange currentRange = [string rangeOfString:struggle];
        NSString *allDataStr = [string substringFromIndex:currentRange.location + 1];
        NSArray *allDataArray = [allDataStr componentsSeparatedByString:NSLocalizedString(separator, nil)];
        for (NSInteger itemIndex = 0; itemIndex < allDataArray.count; itemIndex ++)
        {
            NSString *dicStr = allDataArray[itemIndex];
            NSRange range = [dicStr rangeOfString:dengyuhao];
            NSString *key = [dicStr substringToIndex:range.location];
            NSString *value = [dicStr substringFromIndex:range.location + 1];
            [tagDic setObject:value forKey:key];
        }
        
        if ([string rangeOfString:article_detail].location != NSNotFound )
        {
            [tagDic setObject:article_detail forKey:@"type"];
        }
        if ([string rangeOfString:industry_detail].location != NSNotFound)
        {
            [tagDic setObject:industry_detail forKey:@"type"];
        }
    }
    
    return tagDic;
}

#pragma mark - 内联函数把@“#ff3344”转成UIColor
+ (UIColor *) stringTOColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

#pragma mark - uiclolr -->  uiimage
+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - AttributedString
+ (NSMutableAttributedString *)setAttributedStringStr:(NSString *)str lineSpacing:(CGFloat )lineSpacing fond:(UIFont *)fond color:(UIColor *)color
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrapStyle setLineSpacing:lineSpacing];
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragrapStyle range:NSMakeRange(0, str.length)];
    [attrString addAttribute:NSFontAttributeName value:fond range:NSMakeRange(0, str.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, str.length)];
    
    return attrString;
}

+ (NSMutableAttributedString *)setStrikethroughAttributedStringWithString:(NSString *)string font:(UIFont *)font colr:(UIColor *)color {
    
    NSMutableAttributedString *attrString =
    [[NSMutableAttributedString alloc] initWithString:string
                                           attributes:@{NSFontAttributeName:font,
                                                        NSForegroundColorAttributeName:color,
                                                        NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
                                                        NSStrikethroughColorAttributeName:color}];
    
    return  attrString;

}

/**
 * 解析URL参数的工具方法。
 */
+ (NSDictionary *)parseURLParams:(NSString *)query{
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        if (kv.count == 2) {
            NSString *val =[[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [params setObject:val forKey:[kv objectAtIndex:0]];
        }
    }
    return params;
}

@end
