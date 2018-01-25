//
//  UITabBar+Extend.m
//  Football
//
//  Created by Lost on 15/11/30.
//  Copyright © 2015年 lost. All rights reserved.
//

#import "UITabBar+Extend.h"

@implementation UITabBar (Extend)
/**
 * Hide 1px hairline of the nav bar
 */
- (void)hideTopHairline {
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    UIImage* bgImage = [UIColor imageWithColor:[UIColor whiteColor] size:self.bounds.size];
    [[UITabBar appearance] setBackgroundImage:bgImage];
}

/**
 * Hide 1px hairline of the nav bar
 */
- (void)backTopHairline {
    [self hideTopHairline];
    
    UIImageView* line = [self viewWithTag:667];
    if (line == nil) {
        line = [[UIImageView alloc] init];
        [self addSubview:line];
    }
    line.tag = 667;
    line.backgroundColor = [UIColor colorWithHexColorString:@"a6a6a6"];
    
    CGRect rc = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    [line setFrame:rc];
    [self sendSubviewToBack:line];
}

@end
