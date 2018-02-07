//
//  LogInViewController.m
//  GTarcade
//
//  Created by Lost on 2017/12/26.
//  Copyright © 2017年 VisonCui. All rights reserved.
//

#import "LogInViewController.h"
#import "LoginViewModel.h"
#import "SignUpViewController.h"
#import "ForgotViewController.h"

@interface LogInViewController ()<UIGestureRecognizerDelegate,YYTextViewDelegate>
@property (nonatomic, retain) UIScrollView  *scrollView;
@property (nonatomic, retain) UIImageView   *imageView;
@property (nonatomic, retain) UITextField   *nameTextField;
@property (nonatomic, retain) UITextField   *pwdTextField;
@property (nonatomic, retain) UIButton      *loginButton;
@property (nonatomic, retain) UIButton      *forgotButton;
@property (nonatomic, retain) UIButton      *signUpButton;
@property (nonatomic, strong) YYLabel       *readLabel;

@property (nonatomic, retain) UIButton      *selectButton;
@property (nonatomic, assign, getter=isSelect) BOOL select;

@property (nonatomic, retain) UIButton      *fbButton;
@property (nonatomic, retain) UIButton      *ttButton;
//@property (nonatomic, retain) UIButton      *gcButton;

@property (nonatomic, strong) LoginViewModel *viewModel;

@end

@implementation LogInViewController

- (LoginViewModel*)viewModel
{
    if (!_viewModel) {
        _viewModel = [LoginViewModel new];
    }
    return _viewModel;
}

-(void)loadView
{
    [super loadView];
    
    [self.cusnavigationBar removeFromSuperview];
    _scrollView = [UIScrollView new];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(-20);
    }];
    
    [self.scrollView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView);
        make.size.mas_equalTo(CGSizeMake(120, 50));
        make.top.offset(NavigationBarHeight+20);
    }];
    
    UIView* inputFrameView = [UIView new];
    inputFrameView.backgroundColor = [UIColor whiteColor];
    inputFrameView.layer.borderColor = hexColor(ced0d4).CGColor;
    inputFrameView.layer.borderWidth = 1;
    inputFrameView.layer.cornerRadius = 5;
    inputFrameView.hidden = YES;
    [self.scrollView addSubview:inputFrameView];
    
    [inputFrameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(12);
        make.width.mas_equalTo(@(SCREEN_WIDTH-48));
        make.centerX.equalTo(self.scrollView);
        make.height.mas_equalTo(@(110));
    }];
    
    
    
//    self.nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号"];
    
    
    [self.scrollView addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(inputFrameView);
        make.bottom.equalTo(inputFrameView.mas_centerY).offset(-1);
        make.height.mas_equalTo(@(40));
        make.width.equalTo(inputFrameView).multipliedBy(0.99);
    }];
    [self.scrollView addSubview:self.pwdTextField];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(inputFrameView).offset(1);
        make.centerX.height.width.equalTo(self.nameTextField);
    }];
    
    UIView* lineView = [UIView new];
    lineView.backgroundColor = hexColor(ced0d4);
    [self.scrollView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(inputFrameView);
        make.top.equalTo(self.nameTextField.mas_bottom).offset(4);
        make.height.mas_equalTo(@(0.5));
    }];
    
    UIView* lineView2 = [UIView new];
    lineView2.backgroundColor = hexColor(ced0d4);
    [self.scrollView addSubview:lineView2];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(inputFrameView);
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(4);
        make.height.mas_equalTo(@(0.5));
    }];
    
    UIImageView* leftView = [[UIImageView alloc] initWithImage:ImageNamed(@"手机号码")];
    leftView.contentMode = UIViewContentModeCenter;
    UIImageView* rightView = [[UIImageView alloc] initWithImage:ImageNamed(@"密码")];
    rightView.contentMode = UIViewContentModeCenter;
    self.nameTextField.leftView = leftView;
    self.nameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.nameTextField.leftView.width = 50;
    self.pwdTextField.leftView = rightView;
    self.pwdTextField.leftViewMode = UITextFieldViewModeAlways;
    self.pwdTextField.leftView.width = 50;
//    self.pwdTextField.backgroundColor = RandomColor;
    self.nameTextField.placeholder = @"请输入手机号";
    self.pwdTextField.placeholder = @"请输入密码";
    
    [self.nameTextField setValue:hexColor(666666) forKeyPath:@"_placeholderLabel.textColor"];
    [self.nameTextField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    [self.pwdTextField setValue:hexColor(666666) forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwdTextField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    
//    [self.loginButton setTitle:@"Log In" forState:UIControlStateNormal];
    
    
    [self.forgotButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.scrollView addSubview:self.forgotButton];
    [self.forgotButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pwdTextField).offset(-2);
        make.top.equalTo(inputFrameView.mas_bottom).offset(8);
//        make.left.equalTo(inputFrameView).offset(1);
        make.height.mas_equalTo(@(20));
    }];
    
    [self.scrollView addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forgotButton.mas_bottom).offset(12);
        make.centerX.equalTo(self.scrollView);
        make.width.equalTo(inputFrameView);
        make.height.mas_equalTo(@(40));
    }];
    
//    [self.signUpButton setTitle:@"Sign up" forState:UIControlStateNormal];
    [self.scrollView addSubview:self.signUpButton];
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.height.equalTo(self.loginButton);
        make.top.equalTo(self.loginButton.mas_bottom).offset(10);
    }];
    
    [self.scrollView addSubview:self.readLabel];
    //    [self.readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    ////        make.width.centerX.equalTo(self.mailTextField);
    //        make.top.equalTo(self.pwdCopyTextField.mas_bottom).offset(15);
    //    }];
    CGFloat topMar = 120;
    if (iphone_3_5) {
        topMar = 140;
    }
    if (iphone_4_0) {
        topMar = 180;
    }
    if (iphone_4_7 || iphone_5_5) {
        topMar = 220;
    }
    if (iphoneX) {
        topMar = 180;
    }
    CGFloat topReadPos = topMar+40*3+20+15+10+15+15+6;
    NSString* basic = @"  点击立即注册代表已经同意《吉速派服务协议》";
    NSString* service = @"《吉速派服务协议》";
    self.selectButton.frame = CGRectMake(0, 0, 13, 13);
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] init];
    [attrStr appendAttributedString:[[NSMutableAttributedString alloc] initWithString:basic]];
    NSRange range_service = [attrStr.mutableString rangeOfString:service];
    
    [attrStr setLineSpacing:6];
    [attrStr setFont:Font_System(11)];
    [attrStr setColor:hexColor(69707d)];
    [attrStr setColor:hexColor(5890FF) range:range_service];
    [attrStr setAlignment:NSTextAlignmentCenter];
    CGSize size = CGSizeMake(SCREEN_WIDTH-50, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:attrStr];
    self.readLabel.size = layout.textBoundingSize;
    self.readLabel.top = topReadPos;
    self.readLabel.left = 25;
    self.readLabel.textLayout = layout;
    self.readLabel.userInteractionEnabled = YES;
    
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.fillColor = [UIColor lightGrayColor];
    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setBackgroundBorder:highlightBorder];
    [attrStr setTextHighlight:highlight range:range_service];
    
    self.readLabel.attributedText = attrStr;
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSpace)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    [self.forgotButton addTarget:self action:@selector(forgot) forControlEvents:UIControlEventTouchUpInside];
    
    @weakify(self);
    self.readLabel.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
        @strongify(self);
        
        LostWebViewController* vc = [LostWebViewController new];
        vc.cusnavigationBar.titleLabel.text = @"用户协议";
        [vc startWithUrl:API_userprotoco title:@"用户协议"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    };
}

- (void)login
{
    NSString* value = [NSString trimWhitespaceAndNewline:self.nameTextField.text];
    if ([NSString isBlankString:value]) {
        [HUD showMsg:@"请输入手机号码"];
        return;
    }
    if (![NSString isMobileNumber:value]) {
        [HUD showMsg:@"手机号码格式不对"];
        return;
    }
    
    NSString* pwd = [NSString trimWhitespaceAndNewline:self.pwdTextField.text];
    if ([NSString isBlankString:pwd]) {
        [HUD showMsg:@"请输入密码"];
        return;
    }
    
    
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setObject:value forKey:@"loginname"];
    [parameters setObject:[pwd md5] forKey:@"password"];

    @weakify(self);
    [LostHttpClient GETRequestURL:API_login WithParameter:parameters
             WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
                 @strongify(self);
                 if (appendData.flag == YES) {
                     [UserManager sharedInstance].loginname = value;
                     [UserManager sharedInstance].password = pwd;
                     [self performSelector:@selector(sendSuccess) withObject:nil afterDelay:0.3];
                 }
                 else
                 {
                     [HUD showMsg:appendData.msg type: HUDMsgType_Error];
                 }
             }
                 WithFailureBlock:^{
                     
                 }];
}

- (void)sendSuccess
{
    [[UserManager sharedInstance] getUserDatafromNetWork];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signUp
{
    SignUpViewController* vc = [SignUpViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)forgot
{
    ForgotViewController* vc = [ForgotViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIGestureRecognizerDelegate
- (void)touchSpace
{
    if (self.nameTextField) {
        [self.nameTextField resignFirstResponder];
    }
    if (self.pwdTextField) {
        [self.pwdTextField resignFirstResponder];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch  {
    //    NSLog(@"%@", NSStringFromClass([touch.view class]));
    if ([touch.view isKindOfClass:[UITextField class]] ||
        [touch.view isKindOfClass:[YYTextContainerView class]] ||
        [touch.view isKindOfClass:[YYLabel class]]) {
        return NO;
    }
    return  YES;
}


- (UIButton*)selectButton
{
    if (!_selectButton) {
        _selectButton = [UIButton new];
        [_selectButton setBackgroundImage:ImageNamed(@"pic_kuang") forState:UIControlStateNormal];
    }
    return _selectButton;
}

- (UITextField*)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [UITextField new];
    }
    return _nameTextField;
}

- (UITextField*)pwdTextField
{
    if (!_pwdTextField) {
        _pwdTextField = [UITextField new];
        _pwdTextField.secureTextEntry = YES;
    }
    return _pwdTextField;
}

- (UIButton*)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton new];
        [_loginButton orangeSolidStyle];
        [_loginButton setBackgroundImage:[UIImage imageWithColor:hexColor(5651f7)] forState:UIControlStateNormal];
        [_loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
    }
    return _loginButton;
}

- (UIButton*)forgotButton
{
    if (!_forgotButton) {
        _forgotButton = [UIButton new];
        [_forgotButton orangeNoBorderHollowStyle];
        [_forgotButton setTitleColor:hexColor(666666) forState:UIControlStateNormal];
    }
    return _forgotButton;
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

- (UIButton*)signUpButton
{
    if (!_signUpButton) {
        _signUpButton = [UIButton new];
        [_signUpButton borderHollowStyleforC:hexColor(5651f7) H:[UIColor grayColor] font:Font_System_Bold(15) border:0.6];
        [_signUpButton setTitle:@"新用户注册" forState:UIControlStateNormal];
    }
    return _signUpButton;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = ImageNamed(@"logo");
    }
    return _imageView;
}

@end
