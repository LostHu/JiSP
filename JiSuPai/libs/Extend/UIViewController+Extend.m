//
//  UIViewController+BackButtonHandler.m
//  Football
//
//  Created by Lost on 16/3/2.
//  Copyright © 2016年 崔伟战. All rights reserved.
//

#import "UIViewController+Extend.h"

@implementation UIViewController (BackButtonHandler)

+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
//    resultVC = [self _topViewController:[((MainViewController*)resultVC) homeTabController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
