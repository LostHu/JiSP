//
//  YZRoutes.m
//  GTarcade
//
//  Created by Lost on 2017/12/25.
//  Copyright © 2017年 VisonCui. All rights reserved.
//

#import "YZRoutes.h"

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
