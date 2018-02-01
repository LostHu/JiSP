//
//  ForgotViewController.m
//  GTarcade
//
//  Created by Lost on 2017/12/28.
//  Copyright © 2017年 VisonCui. All rights reserved.
//

#import "ForgotViewController.h"
#import "ForgotSuccessViewController.h"

@interface ForgotViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, retain) UIScrollView  *scrollView;
@property (nonatomic, retain) UITextField   *mailTextField;
@property (nonatomic, retain) UIButton      *signUpButton;
@property (nonatomic, retain) UIButton      *loginButton;
@property (nonatomic, strong) YYLabel       *readLabel;
@end

@implementation ForgotViewController

-(void)loadView
{
    [super loadView];
    
    [self.cusnavigationBar removeFromSuperview];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(@(42));
    }];
    
    UIView* lineView = [UIView new];
    lineView.backgroundColor = hexColor(ababab);
    [self.view addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self.view);
        make.bottom.equalTo(self.loginButton.mas_top).offset(0);
        make.height.mas_equalTo(@(1));
    }];
    
    
    _scrollView = [UIScrollView new];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview: self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(lineView.mas_top);
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
    
    [self.scrollView addSubview:self.mailTextField];
    [self.mailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView);
        make.top.equalTo(titleLabel.mas_bottom).offset(32);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-30, 40));
    }];
    
    [self.scrollView addSubview:self.readLabel];
    //    [self.readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    ////        make.width.centerX.equalTo(self.mailTextField);
    //        make.top.equalTo(self.pwdCopyTextField.mas_bottom).offset(15);
    //    }];
    CGFloat topReadPos = topMar+40+20+15+30+12;
    NSString* basic = @"Please enter your Account Email. If you have set up a Recovery Email, the passwordwill be mailed there instead of to your Account Email.";
    NSString* service = @"A message has been sent to your email.Please verify an email from GTArcade and click on the included link to reset your password.";
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] init];
    [attrStr appendAttributedString:[[NSMutableAttributedString alloc] initWithString:basic]];
    
    [attrStr setLineSpacing:8];
    [attrStr setFont:Font_System(12)];
    [attrStr setColor:hexColor(69707d)];
    CGSize size = CGSizeMake(SCREEN_WIDTH-32, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:attrStr];
    self.readLabel.size = layout.textBoundingSize;
    self.readLabel.top = topReadPos;
    self.readLabel.left = 16;
    self.readLabel.textLayout = layout;
    
    self.mailTextField.placeholder = @"Enter your email";
    [self.signUpButton setTitle:@"Continute" forState:UIControlStateNormal];
    [self.loginButton setTitle:@"Allready have an account? Log in here!" forState:UIControlStateNormal];
    
    [self.scrollView addSubview:self.signUpButton];
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.readLabel.mas_bottom).offset(27);
        make.centerX.equalTo(self.scrollView);
        make.width.equalTo(self.mailTextField);
        make.height.mas_equalTo(@(36));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSpace)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    [self.signUpButton addTarget:self action:@selector(forgot) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton addTarget:self action:@selector(returnLogin) forControlEvents:UIControlEventTouchUpInside];
}

- (void)forgot
{
    ForgotSuccessViewController* vc = [ForgotSuccessViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)returnLogin
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchSpace
{
    if (self.mailTextField) {
        [self.mailTextField resignFirstResponder];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch  {
//    NSLog(@"%@", NSStringFromClass([touch.view class]));
    if ([touch.view isKindOfClass:[UITextField class]]) {
        return NO;
    }
    return  YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (YYLabel*)readLabel
{
    if (!_readLabel) {
        _readLabel = [YYLabel new];
        //        _readLabel.backgroundColor = RandomColor;
        _readLabel.numberOfLines = 0;
        //        _readLabel.font = Font_System(12);
        //        _readLabel.textColor = hexColor(69707d);
    }
    return _readLabel;
}

- (UITextField*)mailTextField
{
    if (!_mailTextField) {
        _mailTextField = [UITextField new];
        _mailTextField.backgroundColor = [UIColor whiteColor];
        _mailTextField.layer.cornerRadius = 5;
        _mailTextField.clipsToBounds = YES;
        UIView* spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 40)];
        _mailTextField.leftView = spaceView;
        _mailTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _mailTextField;
}

- (UIButton*)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton new];
        //        [_loginButton setBackgroundColor:self.view.backgroundColor];
        [_loginButton setBackgroundImage:[UIImage imageWithColor:self.view.backgroundColor] forState:UIControlStateNormal];
        [_loginButton setTitleColor:hexColor(4b4b4b) forState:UIControlStateNormal];
        _loginButton.titleLabel.font = Font_System(12);
    }
    return _loginButton;
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
