//
//  LostWebViewController.m
//  GameBiBi
//
//  Created by Lost on 2017/11/17.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import "LostWebViewController.h"

@interface LostWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, assign) BOOL bScrollInteing;
@property (nonatomic, assign) CGSize lastWebContenSize;
@end

@implementation LostWebViewController

- (void)loadView
{
    [super loadView];
    [self.view addSubview:self.webView];

    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.cusnavigationBar.mas_bottom);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation  -   End of Scrolling.");
    _bScrollInteing = NO;
}

- (void)startWithUrl:(NSString*)url title:(NSString*)title
{
    self.cusnavigationBar.titleLabel.text = title;
    if(![NSString isBlankString:url])
    {
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]] ;
        [self.webView loadRequest:request];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [self.webView sizeToFit];
}

- (WKWebView*)webView
{
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = [[WKUserContentController alloc] init];
        
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
//        preferences.minimumFontSize = 30.0;
        config.preferences = preferences;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:config];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _webView.scrollView.bounces = NO;
//        _webView.scrollView.scrollEnabled = NO;
        _webView.contentMode = UIViewContentModeScaleAspectFit;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        
//        if ([_webView respondsToSelector:@selector(setNavigationDelegate:)]) {
//            [_webView setNavigationDelegate:self];
//        }
//
//        if ([_webView respondsToSelector:@selector(setDelegate:)]) {
//            [_webView setUIDelegate:self];
//        }
    }
    
    return _webView;
}
@end
