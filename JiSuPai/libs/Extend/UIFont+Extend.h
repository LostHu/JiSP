//
//  UIFont+Extend.h
//  Football
//
//  Created by lost on 15/7/13.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Extend)

/**
 *  打印并显示所有字体
 */
+(void)showAllFonts;


/**
 *  宋体(字体缺失)
 */
+(UIFont *)songTypefaceFontOfSize:(CGFloat)size;


/**
 *  黑体：正常字体
 */
+(UIFont *)heitiTypefaceFontOfSize:(CGFloat)size;


/**
 *  微软雅黑：正常字体
 */
+(UIFont *)microsoftYaHeiFontOfSize:(CGFloat)size;


/**
 *  微软雅黑：加粗字体(字体缺失)
 */
+(UIFont *)boldMicrosoftYaHeiFontOfSize:(CGFloat)size;


/**
 *  DroidSansFallback
 */
+(UIFont *)customFontNamedDroidSansFallbackWithFontOfSize:(CGFloat)size;
@end
