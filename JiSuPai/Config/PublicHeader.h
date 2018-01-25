//
//  PublicHeader.h
//  Football
//
//  Created by lost on 15/7/13.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#ifndef Football_Header_h
#define Football_Header_h

#endif

#import <UIKit/UIKit.h>

#define WS(weakSelf)                        __weak __typeof(&*self)weakSelf = self;
#define StrongSelf(type)                     __strong typeof(type) type = weak##type;

#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#define NSUserDefaultsStandard   [NSUserDefaults standardUserDefaults]
//#define AppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]

#pragma mark - 屏幕 functions
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define Screen_Width_Scale (SCREEN_WIDTH*1.0/375.0)

#define StatusBarHeight     [[UIApplication sharedApplication] statusBarFrame].size.height
#define NBarHeight          44
#define UITabBarHeight      49

#define NavigationBarHeight (NBarHeight + StatusBarHeight)

#pragma mark - 系统参数 functions
#define SYSTEMVER       ([[UIDevice currentDevice] systemVersion])
#define SYSTEMVER_F     [SYSTEMVER floatValue]
#define SYSTEM_LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])

//ios系统版本
#define iphone_3_5  (SCREEN_HEIGHT == 480.0f)
#define iphone_4_0  (SCREEN_HEIGHT == 568.0f)
#define iphone_4_7  (SCREEN_HEIGHT == 667.0f)
#define iphone_5_5  (SCREEN_HEIGHT == 736.0f || SCREEN_WIDTH == 414.0f)
#define iphoneX     (SCREEN_HEIGHT == 812.0f && SCREEN_WIDTH == 375.0f)

#define SafeAreaHeight  (iphoneX ? 33 : 0)

#pragma mark - 字体|颜色 functions
#define Font_System(size)                               [UIFont systemFontOfSize:size]
#define Font_System_Bold(size)                          [UIFont boldSystemFontOfSize:size]

/** 普通定义 */
#define rgb(r,g,b)      [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define rgba(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define rgbfromHex(value)       [UIColor colorWithHexColorString:value]
#define hexColor(colorV)        [UIColor colorWithHexColorString:@#colorV]
#define hexColorAlpha(colorV,a) [UIColor colorWithHexColorString:@#colorV alpha:a];

/** 随机色 */
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0f green:arc4random_uniform(256)/255.0f blue:arc4random_uniform(256)/255.0f alpha:1.0f]

#define TICK   NSDate *TICKTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[TICKTime timeIntervalSinceNow])

#pragma mark - 小技巧|优化 functions

#define FormatStr(f,...)    [NSString stringWithFormat:f, ## __VA_ARGS__]
#define ImageNamed(f)       [UIImage imageNamed:FormatStr(@"%@",f)]
#define URLStr(f)           [NSURL URLWithString:f]

// 安全释放
#define SAFE_RELEASE(x) { [x release]; x = nil; }

// 是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

// 打印出当前函数&行
#define MARK  NSLog(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)
#define SelfClassName [NSString stringWithUTF8String:object_getClassName(self)]

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

// 自定义ARC下的单例
#define DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)sharedInstance;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
__strong static className *_instance; \
+ (className *)sharedInstance { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}\
+ (id)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
-(id)copyWithZone:(NSZone *)zone{\
return _instance;\
}\
