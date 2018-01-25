//
//  UIViewController+BackButtonHandler.h
//  Football
//
//  Created by Lost on 16/3/2.
//  Copyright © 2016年 崔伟战. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BackButtonHandlerProtocol <NSObject>
@optional
// Override this method in UIViewController derived class to handle 'Back' button click
-(BOOL)navigationShouldPopOnBackButton;
@end
@interface UIViewController (BackButtonHandler)<BackButtonHandlerProtocol>

+ (UIViewController *)topViewController;


// 分享
-(void)shareWithLogoStr:(NSString *)logoStr Title:(NSString *)title descr:(NSString *)descrStr webpageUrl:(NSString *)pageUrl;

@end
