//
//  LostWebViewController.h
//  GameBiBi
//
//  Created by Lost on 2017/11/17.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface LostWebViewController : BaseViewController
@property (nonatomic, strong) WKWebView* webView;

- (void)startWithUrl:(NSString*)url title:(NSString*)title;

@end
