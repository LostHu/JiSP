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
@property (nonatomic, strong) UITextField   *codeTextField;
@property (nonatomic, retain) UITextField   *pwdTextField;
@property (nonatomic, retain) UITextField   *inviteTextField;

@property (nonatomic, retain) UIButton      *signUpButton;
@property (nonatomic, retain) UIImageView   *imageView;

@property (nonatomic, retain) UIButton      *loginButton;
@end

@implementation ForgotViewController

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
    
    UIButton* backBtn = [UIButton new];
    [backBtn setImage:ImageNamed(@"tab_back") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(sendSuccess) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(StatusBarHeight);
        make.left.offset(6);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.scrollView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView);
        make.size.mas_equalTo(CGSizeMake(120, 50));
        make.top.offset(NavigationBarHeight+20);
    }];
    
    CGFloat lineHeight = 44;
    
    UIView* lineView = [UIView new];
    lineView.backgroundColor = hexColor(ced0d4);
    [self.scrollView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView);
        make.top.equalTo(self.imageView.mas_bottom).offset(75);
        make.height.mas_equalTo(@(0.5));
        make.width.mas_equalTo(@(SCREEN_WIDTH-60));
    }];
    
    UIView* lineView2 = [UIView new];
    lineView2.backgroundColor = lineView.backgroundColor;
    [self.scrollView addSubview:lineView2];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.height.width.equalTo(lineView);
        make.top.equalTo(lineView.mas_bottom).offset(lineHeight);
    }];
    
    UIView* lineView3 = [UIView new];
    lineView3.backgroundColor = lineView.backgroundColor;
    [self.scrollView addSubview:lineView3];
    
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.height.width.equalTo(lineView);
        make.top.equalTo(lineView2.mas_bottom).offset(lineHeight);
    }];
    
    UIView* lineView4 = [UIView new];
    lineView4.backgroundColor = lineView.backgroundColor;
    [self.scrollView addSubview:lineView4];
    
    [lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.height.width.equalTo(lineView);
        make.top.equalTo(lineView3.mas_bottom).offset(lineHeight);
    }];
    
    [self.scrollView addSubview:self.mailTextField];
    [self.mailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView.mas_top).offset(-1);
        make.height.mas_equalTo(@(40));
        make.left.equalTo(lineView).offset(-16);
        make.right.equalTo(lineView).offset(-76);
    }];
    [self.scrollView addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView2.mas_top).offset(-1);
        make.centerX.equalTo(self.scrollView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-30, 40));
    }];
    [self.scrollView addSubview:self.pwdTextField];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView3.mas_top).offset(-1);
        make.size.centerX.equalTo(self.codeTextField);
    }];
    [self.scrollView addSubview:self.inviteTextField];
    [self.inviteTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView4.mas_top).offset(-1);
        make.size.centerX.equalTo(self.codeTextField);
    }];
    
    [self.scrollView addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inviteTextField.mas_bottom).offset(30);
        make.centerX.equalTo(self.scrollView);
        make.width.equalTo(self.codeTextField);
        make.height.mas_equalTo(@(40));
    }];
    
    self.mailTextField.placeholder = @"手机号";
    self.codeTextField.placeholder = @"验证码";
    self.pwdTextField.placeholder = @"密码";
    self.inviteTextField.placeholder = @"确认密码";
    
    UIImageView* leftView = [[UIImageView alloc] initWithImage:ImageNamed(@"手机号码")];
    leftView.contentMode = UIViewContentModeCenter;
    UIImageView* rightView = [[UIImageView alloc] initWithImage:ImageNamed(@"验证码")];
    rightView.contentMode = UIViewContentModeCenter;
    self.mailTextField.leftView = leftView;
    self.mailTextField.leftViewMode = UITextFieldViewModeAlways;
    self.mailTextField.leftView.width = 50;
    self.codeTextField.leftView = rightView;
    self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
    self.codeTextField.leftView.width = 50;
    
    UIImageView* topView = [[UIImageView alloc] initWithImage:ImageNamed(@"密码")];
    topView.contentMode = UIViewContentModeCenter;
    UIImageView* bottomView = [[UIImageView alloc] initWithImage:ImageNamed(@"密码")];
    bottomView.contentMode = UIViewContentModeCenter;
    self.pwdTextField.leftView = topView;
    self.pwdTextField.leftViewMode = UITextFieldViewModeAlways;
    self.pwdTextField.leftView.width = 50;
    self.inviteTextField.leftView = bottomView;
    self.inviteTextField.leftViewMode = UITextFieldViewModeAlways;
    self.inviteTextField.leftView.width = 50;
    
    [self.mailTextField setValue:hexColor(666666) forKeyPath:@"_placeholderLabel.textColor"];
    [self.mailTextField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    [self.pwdTextField setValue:hexColor(666666) forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwdTextField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    [self.codeTextField setValue:hexColor(666666) forKeyPath:@"_placeholderLabel.textColor"];
    [self.codeTextField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    [self.inviteTextField setValue:hexColor(666666) forKeyPath:@"_placeholderLabel.textColor"];
    [self.inviteTextField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    
    self.mailTextField.font = Font_System(12);
    self.codeTextField.font = Font_System(12);
    self.inviteTextField.font = Font_System(12);
    self.pwdTextField.font = Font_System(12);
    
    [self.loginButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.scrollView addSubview:self.signUpButton];
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mailTextField).offset(0);
        make.right.equalTo(lineView).offset(-2);
        //        make.width.equalTo(self.mailTextField);
        make.size.mas_equalTo(CGSizeMake(68, 28));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSpace)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    [self.signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
}

- (void)signUp
{
    NSString* value = [NSString trimWhitespaceAndNewline:self.mailTextField.text];
    if ([NSString isBlankString:value]) {
        [HUD showMsg:@"请输入手机号码"];
        return;
    }
    if (![NSString isMobileNumber:value]) {
        [HUD showMsg:@"手机号码格式不对"];
        return;
    }
    
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setObject:value forKey:@"phone"];
    [parameters setObject:@"reset" forKey:@"type"];
    
    @weakify(self);
    [LostHttpClient GETRequestURL:API_sendPhoneCode WithParameter:parameters
             WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
                 @strongify(self);
                 if (appendData.flag == YES) {
                     [self changeCountDown];
                 }
                 else
                 {
                     [HUD showMsg:appendData.msg type: HUDMsgType_Error];
                 }
             }
                 WithFailureBlock:^{
                     
                 }];
}

- (void)changeCountDown
{
    __block int timeout = 59; //倒计时时间
    
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0),1.0*NSEC_PER_SEC,0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){//倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示根据自己需求设置
                
                [self.signUpButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                
                self.signUpButton.enabled = YES;//设置button可点击
                
            });
            
        }else{
            
            //int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示根据自己需求设置
                
                NSLog(@"____%@",strTime);
                
                [self.signUpButton setTitle:[NSString stringWithFormat:@"剩余%@秒",strTime]forState:UIControlStateNormal];
                
                self.signUpButton.enabled = NO;//设置button不可点击
                
                //do what you are want
                
                
                
                
                
            });
            
            timeout--;
            
            
            
        }
        
    });
    
    dispatch_resume(_timer);
}


- (void)registerAccount
{
    NSString* value = [NSString trimWhitespaceAndNewline:self.mailTextField.text];
    if ([NSString isBlankString:value]) {
        [HUD showMsg:@"请输入手机号码"];
        return;
    }
    if (![NSString isMobileNumber:value]) {
        [HUD showMsg:@"手机号码格式不对"];
        return;
    }
    
    NSString* code = [NSString trimWhitespaceAndNewline:self.codeTextField.text];
    if ([NSString isBlankString:code]) {
        [HUD showMsg:@"请输入验证码"];
        return;
    }
    NSString* pwd = [NSString trimWhitespaceAndNewline:self.pwdTextField.text];
    if ([NSString isBlankString:pwd]) {
        [HUD showMsg:@"请输入密码"];
        return;
    }
    
    NSString* invite = [NSString trimWhitespaceAndNewline:self.inviteTextField.text];
    
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setObject:value forKey:@"phone"];
    [parameters setObject:code forKey:@"phonecode"];
    [parameters setObject:pwd forKey:@"password"];
    if (![NSString isBlankString:invite]) {
        [parameters setObject:invite forKey:@"yaoqingma"];
    }
    
    @weakify(self);
    [LostHttpClient GETRequestURL:API_resetPassword_Reset WithParameter:parameters
             WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
                 @strongify(self);
                 if (appendData.flag == YES) {
                     [HUD showMsg:@"重置成功，请重新登录" type:HUDMsgType_Success];
                     [self performSelector:@selector(sendSuccess) withObject:nil afterDelay:0.6];
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchSpace
{
    if (self.mailTextField) {
        [self.mailTextField resignFirstResponder];
    }
    if (self.pwdTextField) {
        [self.pwdTextField resignFirstResponder];
    }
    if (self.codeTextField) {
        [self.codeTextField resignFirstResponder];
    }
    if (self.inviteTextField) {
        [self.inviteTextField resignFirstResponder];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch  {
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    if ([touch.view isKindOfClass:[UITextField class]]) {
        return NO;
    }
    return  YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (UITextField*)codeTextField
{
    if (!_codeTextField) {
        _codeTextField = [UITextField new];
        _codeTextField.backgroundColor = [UIColor whiteColor];
        _codeTextField.layer.cornerRadius = 5;
        _codeTextField.clipsToBounds = YES;
        UIView* spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 40)];
        _codeTextField.leftView = spaceView;
        _codeTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _codeTextField;
}

- (UITextField*)pwdTextField
{
    if (!_pwdTextField) {
        _pwdTextField = [UITextField new];
        _pwdTextField.backgroundColor = [UIColor whiteColor];
        _pwdTextField.layer.cornerRadius = 5;
        _pwdTextField.clipsToBounds = YES;
        _pwdTextField.secureTextEntry = YES;
        UIView* spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 40)];
        _pwdTextField.leftView = spaceView;
        _pwdTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _pwdTextField;
}

- (UITextField*)inviteTextField
{
    if (!_inviteTextField) {
        _inviteTextField = [UITextField new];
        _inviteTextField.backgroundColor = [UIColor whiteColor];
        _inviteTextField.layer.cornerRadius = 5;
        _inviteTextField.clipsToBounds = YES;
        _inviteTextField.secureTextEntry = YES;
        UIView* spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 40)];
        _inviteTextField.leftView = spaceView;
        _inviteTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _inviteTextField;
}

- (UIButton*)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton new];
        [_loginButton orangeSolidStyle];
        [_loginButton setBackgroundImage:[UIImage imageWithColor:hexColor(5651f7)] forState:UIControlStateNormal];
        [_loginButton setTitle:@"立即注册" forState:UIControlStateNormal];
    }
    return _loginButton;
}

- (UIButton*)signUpButton
{
    if (!_signUpButton) {
        _signUpButton = [UIButton new];
        [_signUpButton borderHollowStyleforC:hexColor(5758f3) H:hexColor(666666) font:Font_System(14) border:1];
        [_signUpButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _signUpButton.layer.cornerRadius = 14;
        _signUpButton.titleLabel.font = Font_System(11);
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
