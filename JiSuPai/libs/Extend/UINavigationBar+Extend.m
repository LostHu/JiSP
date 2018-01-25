//
//  UINavigationBar+Extend.m
//  Football
//
//  Created by Lost on 15/9/7.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "UINavigationBar+Extend.h"

@implementation UINavigationBar (Extend)

/**
 * Hide 1px hairline of the nav bar
 */
- (void)hideBottomHairline {
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self];
    navBarHairlineImageView.hidden = YES;
}

/**
 * Show 1px hairline of the nav bar
 */
- (void)showBottomHairline {
    // Show 1px hairline of translucent nav bar
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self];
    navBarHairlineImageView.hidden = NO;
}


- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)makeTransparent {
    [self setTranslucent:YES];
    
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.backgroundColor = [UIColor clearColor];
    self.shadowImage = [UIImage new];    // Hides the hairline
    [self hideBottomHairline];
}

- (void)drawRect:(CGRect)rect {
    
    UIColor *color = [UIColor blueColor];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColor(context, CGColorGetComponents( [color CGColor]));
    
    CGContextFillRect(context, rect);
    
}

@end
