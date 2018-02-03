//
//  SignUpViewController.m
//  GTarcade
//
//  Created by Lost on 2017/12/28.
//  Copyright © 2017年 VisonCui. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()<UIGestureRecognizerDelegate,YYTextViewDelegate>
@property (nonatomic, retain) UIScrollView  *scrollView;
@property (nonatomic, retain) UITextField   *mailTextField;
@property (nonatomic, strong) UITextField*  codeTextField;
@property (nonatomic, retain) UITextField   *pwdTextField;
@property (nonatomic, retain) UITextField   *inviteTextField;
@property (nonatomic, retain) UIButton      *signUpButton;
@property (nonatomic, retain) UIImageView   *imageView;

@property (nonatomic, strong) YYLabel       *readLabel;

@property (nonatomic, retain) UIButton      *loginButton;
@property (nonatomic, retain) UIButton      *selectButton;
@property (nonatomic, assign, getter=isSelect) BOOL select;
@end

@implementation SignUpViewController

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
        make.size.mas_equalTo(CGSizeMake(60, 40));
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
    
    
    CGFloat topMar = 120;
    if (iphone_3_5) {
        topMar = 80;
    }
    if (iphone_4_0) {
        topMar = 140;
    }
    if (iphone_4_7 || iphone_5_5) {
        topMar = 220;
    }
    if (iphoneX) {
        topMar = 180;
    }
    
    
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
    
    [self.scrollView addSubview:self.readLabel];
//    [self.readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.width.centerX.equalTo(self.mailTextField);
//        make.top.equalTo(self.pwdCopyTextField.mas_bottom).offset(15);
//    }];
    CGFloat topReadPos = topMar+40*3+20+15+10+15+15+6+20;
    NSString* basic = @"  点击立即注册代表已经同意《吉速派服务协议》";
    NSString* service = @"《吉速派服务协议》";
    self.selectButton.frame = CGRectMake(0, 0, 13, 13);
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString* attachment = [NSMutableAttributedString attachmentStringWithContent:self.selectButton
                                                                                       contentMode:UIViewContentModeCenter
                                                                                    attachmentSize:self.selectButton.size alignToFont:Font_System(12) alignment:YYTextVerticalAlignmentCenter];
    [attrStr appendAttributedString:attachment];
    [attrStr appendAttributedString:[[NSMutableAttributedString alloc] initWithString:basic]];
    NSRange range_service = [attrStr.mutableString rangeOfString:service];
    
    [attrStr setLineSpacing:6];
    [attrStr setFont:Font_System(12)];
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
    
    self.mailTextField.placeholder = @"手机号";
    self.codeTextField.placeholder = @"验证码";
    self.pwdTextField.placeholder = @"密码";
    self.inviteTextField.placeholder = @"邀请码";
    
    UIImageView* leftView = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_pl")];
    leftView.contentMode = UIViewContentModeCenter;
    UIImageView* rightView = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_pl")];
    rightView.contentMode = UIViewContentModeCenter;
    self.mailTextField.leftView = leftView;
    self.mailTextField.leftViewMode = UITextFieldViewModeAlways;
    self.mailTextField.leftView.width = 50;
    self.codeTextField.leftView = rightView;
    self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
    self.codeTextField.leftView.width = 50;
    
    UIImageView* topView = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_pl")];
    topView.contentMode = UIViewContentModeCenter;
    UIImageView* bottomView = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_pl")];
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
    
    [self.loginButton setTitle:@"立即注册" forState:UIControlStateNormal];
    
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
    [self.selectButton addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
    
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
    __block int timeout=60; //倒计时时间
    
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0),1.0*NSEC_PER_SEC,0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){//倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示根据自己需求设置
                
                [self.signUpButton setTitle:@"发送验证码"forState:UIControlStateNormal];
                
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

- (void)changeSelect:(UIButton *)iButton
{
    self.select = !self.isSelect;
    NSString* name = self.isSelect ? @"pic_kuang_pre" : @"pic_kuang";
    [iButton setBackgroundImage:ImageNamed(name) forState:UIControlStateNormal];
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
    [LostHttpClient GETRequestURL:API_registerHuozhu WithParameter:parameters
             WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
                 @strongify(self);
                 if (appendData.flag == YES) {
                     [HUD showMsg:@"注册成功，请重新登录" type:HUDMsgType_Success];
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
    if ([touch.view isKindOfClass:[UITextField class]] ||
        [touch.view isKindOfClass:[YYLabel class]]) {
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
//        _inviteTextField.secureTextEntry = YES;
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

- (UIButton*)selectButton
{
    if (!_selectButton) {
        _selectButton = [UIButton new];
        [_selectButton setBackgroundImage:ImageNamed(@"pic_kuang") forState:UIControlStateNormal];
    }
    return _selectButton;
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
        _imageView.image = ImageNamed(@"pic_bg");
    }
    return _imageView;
}

@end
