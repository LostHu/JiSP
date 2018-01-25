//
//  UINavigationController+ShouldPopOnBackButton.m
//  Football
//
//  Created by Lost on 16/3/2.
//  Copyright © 2016年 崔伟战. All rights reserved.
//

#import "UINavigationController+Extend.h"
#import "UIViewController+Extend.h"

@implementation UINavigationController (ShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item
{
    NSLog(@"shouldPushItem");
    if([self.viewControllers count] > [navigationBar.items count]) {
        
//        UIViewController* topVc = self.viewControllers.lastObject;
//        if ([self.viewControllers count] > 1) {
//            if ([topVc isKindOfClass:[TeamHomeViewController class]]) {
//                [self initDeepStyle];
//            }
//            else
//                [self initLightStyle];
//        }
        
        return YES;
    }
    
    return NO;
}

//- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item
//{
//    NSLog(@"didPushItem");
//    UIViewController* topVc = self.viewControllers.lastObject;
////    if (![topVc isKindOfClass:[MeViewController class]])
//    {
//        if ([self.viewControllers count] > 1) {
//            if ([topVc isKindOfClass:[TeamHomeViewController class]]) {
//                [self initDeepStyle];
//            }
//            else
//                [self initLightStyle];
//        }
//    }
//}
//
//- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item
//{
//    NSLog(@"didPopItem");
//    UIViewController* topVc = self.viewControllers.lastObject;
////    if (![topVc isKindOfClass:[MeViewController class]])
//    {
//        if ([self.viewControllers count] == 1) {
//            [self initDeepStyle];
//        }
//        else
//        {
//            if ([topVc isKindOfClass:[TeamHomeViewController class]]) {
//                [self initDeepStyle];
//            }
//            else
//            {
//                [self initLightStyle];
//            }
//        }
//    }
//}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem*)item {
    NSLog(@"shouldPopItem");
    if([self.viewControllers count] < [navigationBar.items count]) {
//        UIViewController* topVc = self.viewControllers.lastObject;
//        if (self.viewControllers.count == 1) {
//            [self initDeepStyle];
//        }
//        else
//        {
//            if ([topVc isKindOfClass:[TeamHomeViewController class]]) {
//                [self initDeepStyle];
//            }
//            else
//            {
//                [self initLightStyle];
//            }
//        }
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        // Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments /34452906
        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    
    return NO;
}

-(void)initLightStyle
{
    [self.navigationBar showBottomHairline];
    
    // 此处消除背景颜色的透明值,否则会与美术给的颜色值不一样
    self.navigationBar.translucent = NO;
    // 背景色
    [self.navigationBar setBarTintColor:NavBar_BgColor];
    // 标题颜色
    [self.navigationBar setTintColor:YZColor_Text_mainBlue];
    
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:YZColor_Text_mainBlue forKey:NSForegroundColorAttributeName]];
//    [self.navigationBar hideBottomHairline];
    
    //去除系统默认的返回字眼
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:Font_System(14),NSForegroundColorAttributeName:YZColor_Text_mainBlue} forState:UIControlStateNormal];
    
    // 统一替换返回按钮
    //    UIImage *backImage = [[UIImage imageNamed: @"nav_back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    self.navigationBar.backIndicatorImage = backImage;
    //    self.navigationBar.backIndicatorTransitionMaskImage = backImage;
}

-(void)initDeepStyle
{
    [self.navigationBar hideBottomHairline];
    
    // 此处消除背景颜色的透明值,否则会与美术给的颜色值不一样
    self.navigationBar.translucent = NO;
    // 背景色
    [self.navigationBar setBarTintColor:YZColor_Text_mainBlue];
    // 标题颜色
    [self.navigationBar setTintColor:NavBar_BgColor];
    
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:YZColor_Text_mainlight forKey:NSForegroundColorAttributeName]];
    
    //去除系统默认的返回字眼
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:Font_System(14),NSForegroundColorAttributeName:YZColor_White} forState:UIControlStateNormal];

    // 统一替换返回按钮
//    UIImage *backImage = [[UIImage imageNamed: @"nav_back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.navigationBar.backIndicatorImage = backImage;
//    self.navigationBar.backIndicatorTransitionMaskImage = backImage;
}
@end
