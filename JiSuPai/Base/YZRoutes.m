//
//  YZRoutes.m
//  GTarcade
//
//  Created by Lost on 2017/12/25.
//  Copyright © 2017年 VisonCui. All rights reserved.
//

#import "YZRoutes.h"
#import "LogInViewController.h"

@implementation YZRoutes
//DEFINE_SINGLETON_FOR_CLASS(YZRoutes)

+ (void)routeToUserPage4Id:(NSString*)userId
{
    UIViewController* vc = [self topViewController];
    if (vc) {
//        uservie
//        [vc.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>]
    }
}

+ (void)showLoginPage
{
    LogInViewController* vc = [LogInViewController new];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBarHidden = YES;
    UIViewController* current_VC = [self topViewController];
    if (current_VC) {
        [current_VC presentViewController:nav animated:YES completion:nil];
    }
}

+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
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
