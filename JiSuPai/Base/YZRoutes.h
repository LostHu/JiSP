//
//  YZRoutes.h
//  GTarcade
//
//  Created by Lost on 2017/12/25.
//  Copyright © 2017年 VisonCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZRoutes : NSObject
//DEFINE_SINGLETON_FOR_HEADER(YZRoutes)

+ (UIViewController *)topViewController;
+ (void)routeToUserPage4Id:(NSString*)userId;
+ (void)showLoginPage;
@end
