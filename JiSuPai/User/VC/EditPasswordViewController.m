//
//  EditPasswordViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/21.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "EditPasswordViewController.h"

@interface EditPasswordViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITextField* startDateField;
@property (nonatomic, strong) UITextField* endDateField;
@end

@implementation EditPasswordViewController

- (MeViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[MeViewModel alloc] init];
    }
    return _viewModel;
}

- (void)loadView
{
    [super loadView];
    
    UIView* bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(NavigationBarHeight);
        make.height.mas_equalTo(@(160));
    }];
    
    [bgView addSubview: self.startDateField];
    [bgView addSubview: self.endDateField];
    self.startDateField.placeholder = @"请输入新密码";
    self.endDateField.placeholder = @"请再次输入密码";
    
    [self.startDateField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.offset(15);
        make.height.mas_equalTo(@(32));
    }];
    
    [self.endDateField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startDateField.mas_bottom).offset(12);
        make.left.right.height.equalTo(self.startDateField);
    }];
    
    UIButton* addBtn = [UIButton new];
    [addBtn blueSolidStyle];
    [addBtn setTitle:@"确定" forState:UIControlStateNormal];
    [bgView addSubview:addBtn];
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-16);
        make.height.mas_equalTo(@(36));
        make.left.equalTo(self.endDateField);
        make.right.equalTo(self.endDateField);
    }];
    
    [addBtn addTarget:self action:@selector(confirmPwd) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = hexColor(f5f8fa);
    self.cusnavigationBar.titleLabel.text = @"密码修改";
    
    self.startDateField.delegate = self;
    self.endDateField.delegate = self;
    
    self.startDateField.tag = 1001;
    self.endDateField.tag = 1002;
    
    _startDateField.borderStyle = UITextBorderStyleRoundedRect;
    _endDateField.borderStyle = UITextBorderStyleRoundedRect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSpace)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)touchSpace
{
    //    self.maskView.hidden = YES;
    [_startDateField resignFirstResponder];
    [_endDateField resignFirstResponder];
    
    [self.view endEditing:YES];
}

- (void)sendSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITextField*)firstTextField
{
    if (self.startDateField.isFirstResponder) {
        return self.startDateField;
    }
    if (self.endDateField.isFirstResponder) {
        return self.endDateField;
    }
    return nil;
}

- (void)confirmPwd
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITextField*)startDateField
{
    if (!_startDateField) {
        _startDateField = [UITextField new];
        _startDateField.textAlignment = NSTextAlignmentLeft;
        if (SYSTEMVER_F >= 10) {
            _startDateField.textContentType = UITextContentTypePassword;
        }
        else
        {
            _startDateField.secureTextEntry = YES;
        }
        
        _startDateField.font = Font_System(12);
        _startDateField.textColor = hexColor(a1a1a1);
    }
    return _startDateField;
}

- (UITextField*)endDateField
{
    if (!_endDateField) {
        _endDateField = [UITextField new];
        if (SYSTEMVER_F >= 10) {
            _endDateField.textContentType = UITextContentTypePassword;
        }
        else
        {
            _endDateField.secureTextEntry = YES;
        }
        _endDateField.textAlignment = NSTextAlignmentLeft;
        _endDateField.font = Font_System(12);
        _endDateField.textColor = hexColor(a1a1a1);
    }
    return _endDateField;
}

@end
