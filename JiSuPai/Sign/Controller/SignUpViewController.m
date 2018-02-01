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
@property (nonatomic, retain) UITextField   *pwdTextField;
@property (nonatomic, retain) UITextField   *pwdCopyTextField;
@property (nonatomic, retain) UIButton      *signUpButton;

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
    titleLabel.text = @"Join GTarcade";
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
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-30, 40));
    }];
    [self.scrollView addSubview:self.pwdTextField];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mailTextField.mas_bottom).offset(15);
        make.size.centerX.equalTo(self.mailTextField);
    }];
    [self.scrollView addSubview:self.pwdCopyTextField];
    [self.pwdCopyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(10);
        make.size.centerX.equalTo(self.mailTextField);
    }];
    
    [self.scrollView addSubview:self.readLabel];
//    [self.readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.width.centerX.equalTo(self.mailTextField);
//        make.top.equalTo(self.pwdCopyTextField.mas_bottom).offset(15);
//    }];
    CGFloat topReadPos = topMar+40*3+20+15+10+15+15+6;
    NSString* basic = @"  I have read and agree to the Terms of service and Prviacy Policy";
    NSString* service = @"the Terms of service and Prviacy Policy";
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
    CGSize size = CGSizeMake(SCREEN_WIDTH-32, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:attrStr];
    self.readLabel.size = layout.textBoundingSize;
    self.readLabel.top = topReadPos;
    self.readLabel.left = 16;
    self.readLabel.textLayout = layout;
    self.readLabel.userInteractionEnabled = YES;
    
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.fillColor = [UIColor lightGrayColor];
    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setBackgroundBorder:highlightBorder];
    [attrStr setTextHighlight:highlight range:range_service];
    
    self.readLabel.attributedText = attrStr;
    self.mailTextField.placeholder = @"Email";
    self.pwdTextField.placeholder = @"New Password";
    self.pwdCopyTextField.placeholder = @"Re-type Password";
    [self.signUpButton setTitle:@"Sign up" forState:UIControlStateNormal];
    [self.loginButton setTitle:@"Allready have an account? Log in here!" forState:UIControlStateNormal];
    
    [self.scrollView addSubview:self.signUpButton];
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.readLabel.mas_bottom).offset(18);
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
    
    [self.signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton addTarget:self action:@selector(returnLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.selectButton addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    @weakify(self);
    self.readLabel.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
    
        @strongify(self);
        LostWebViewController* vc = [LostWebViewController new];
        [vc startWithUrl:H5_P_Rule title:@"抽奖规则"];
        [self.navigationController pushViewController:vc animated:YES];

    };
}

- (void)signUp
{
    
}

- (void)changeSelect:(UIButton *)iButton
{
    self.select = !self.isSelect;
    NSString* name = self.isSelect ? @"pic_kuang_pre" : @"pic_kuang";
    [iButton setBackgroundImage:ImageNamed(name) forState:UIControlStateNormal];
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
    if (self.pwdTextField) {
        [self.pwdTextField resignFirstResponder];
    }
    if (self.pwdCopyTextField) {
        [self.pwdCopyTextField resignFirstResponder];
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

- (UITextField*)pwdCopyTextField
{
    if (!_pwdCopyTextField) {
        _pwdCopyTextField = [UITextField new];
        _pwdCopyTextField.backgroundColor = [UIColor whiteColor];
        _pwdCopyTextField.layer.cornerRadius = 5;
        _pwdCopyTextField.clipsToBounds = YES;
        _pwdCopyTextField.secureTextEntry = YES;
        UIView* spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 40)];
        _pwdCopyTextField.leftView = spaceView;
        _pwdCopyTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _pwdCopyTextField;
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
        [_signUpButton orangeSolidStyle];
    }
    return _signUpButton;
}

@end
