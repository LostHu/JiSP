//
//  ForgotSuccessViewController.m
//  GTarcade
//
//  Created by Lost on 2017/12/28.
//  Copyright © 2017年 VisonCui. All rights reserved.
//

#import "ForgotSuccessViewController.h"

@interface ForgotSuccessViewController ()
@property (nonatomic, retain) UIScrollView  *scrollView;
@property (nonatomic, retain) UIButton      *signUpButton;
@property (nonatomic, strong) YYLabel       *readLabel;
@end

@implementation ForgotSuccessViewController


-(void)loadView
{
    [super loadView];
    
    [self.cusnavigationBar removeFromSuperview];
    
    _scrollView = [UIScrollView new];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview: self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view);
    }];
    
    UILabel* titleLabel = [UILabel new];
    titleLabel.text = @"Confirm Your Email";
    titleLabel.font = Font_System_Bold(18);
    titleLabel.textColor = hexColor(4b4b4b);
    [self.scrollView addSubview:titleLabel];
    
    CGFloat topMar = 80;
    if (iphone_3_5) {
        topMar = 80;
    }
    if (iphone_4_0) {
        topMar = 110;
    }
    if (iphone_4_7 || iphone_5_5) {
        topMar = 145;
    }
    if (iphoneX) {
        topMar = 155;
    }
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(topMar);
        make.centerX.equalTo(self.scrollView);
    }];
    
    [self.scrollView addSubview:self.readLabel];
    CGFloat topReadPos = topMar+15+30+12;
    NSString* service = @"A message has been sent to your email.Please verify an email from GTArcade and click on the included link to reset your password.";
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] init];
    [attrStr appendAttributedString:[[NSMutableAttributedString alloc] initWithString:service]];
    
    [attrStr setLineSpacing:8];
    [attrStr setFont:Font_System(12)];
    [attrStr setColor:hexColor(69707d)];
    CGSize size = CGSizeMake(SCREEN_WIDTH-32, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:attrStr];
    self.readLabel.size = layout.textBoundingSize;
    self.readLabel.top = topReadPos;
    self.readLabel.left = 16;
    self.readLabel.textLayout = layout;
    
    [self.signUpButton setTitle:@"Back" forState:UIControlStateNormal];
    
    [self.scrollView addSubview:self.signUpButton];
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.readLabel.mas_bottom).offset(27);
        make.centerX.equalTo(self.scrollView);
        make.width.mas_equalTo(@(SCREEN_WIDTH-30));
        make.height.mas_equalTo(@(36));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.signUpButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (YYLabel*)readLabel
{
    if (!_readLabel) {
        _readLabel = [YYLabel new];
        _readLabel.numberOfLines = 0;
    }
    return _readLabel;
}

- (UIButton*)signUpButton
{
    if (!_signUpButton) {
        _signUpButton = [UIButton new];
        [_signUpButton orangeSolidStyle];
    }
    return _signUpButton;
}

@end
