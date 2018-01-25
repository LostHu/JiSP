//
//  UIButton+Extend.h
//  QuickDate
//
//  Created by Lost on 15/12/14.
//  Copyright © 2015年 崔伟战. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extend)
- (void)centerImageAndTitle:(float)space;
- (void)centerImageAndTitle;

- (void)deepSolidCornerStyle;
- (void)deepBorderHollowStyle;

- (void)redSolidCornerStyle;

// 色镂空边框

- (void)blueSolidStyle;
- (void)blueBorderHollowStyle;
- (void)blueHollowStyle;

- (void)redNoBorderHollowStyle;
- (void)graySolidStyle;

- (void)orangeSolidStyle;
- (void)orangeBorderHollowStyle;
- (void)orangeNoBorderHollowStyle;

- (void)borderHollowStyleforC:(UIColor*)normal H:(UIColor*)high font:(UIFont*)font border:(CGFloat)border;
- (void)borderHollowStyleforColor:(UIColor*)normal H:(UIColor*)high font:(UIFont*)font borderColor:(UIColor*)bColor border:(CGFloat)border;

- (void)solidStyleforC:(UIColor*)normal H:(UIColor*)high font:(UIFont*)font corner:(CGFloat)corner;
- (void)solidStyleforC:(UIColor*)normal D:(UIColor*)disable font:(UIFont*)font corner:(CGFloat)corner;

@end
