//
//  AddLeaveViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/26.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "AddLeaveViewController.h"

#define MAX_INPUT_NUM 500

@interface AddLeaveViewController ()<UIPickerViewDelegate,UITextFieldDelegate,YYTextViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITextField* startDateField;
@property (nonatomic, strong) UITextField* endDateField;
@property (nonatomic, strong) YYTextView* textView;
@property (nonatomic, strong) UIDatePicker* datePicker;
@end

@implementation AddLeaveViewController

- (LeaveViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[LeaveViewModel alloc] init];
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
        make.height.mas_equalTo(@(200));
    }];
    
    UILabel* nameLabel = [UILabel new];
    nameLabel.textColor = hexColor(111111);
    nameLabel.text = @"日期:";
    nameLabel.font = Font_System(14);
    [bgView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(18);
        make.top.offset(18);
        make.width.mas_equalTo(@(40));
    }];
    
    UILabel* nameLabel2 = [UILabel new];
    nameLabel2.textColor = hexColor(111111);
    nameLabel2.text = @"描述:";
    nameLabel2.font = Font_System(14);
    [bgView addSubview:nameLabel2];
    [nameLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel).offset(0);
        make.top.equalTo(nameLabel.mas_bottom).offset(48);
    }];
    
    [bgView addSubview: self.startDateField];
    [bgView addSubview: self.endDateField];
    [bgView addSubview: self.textView];
    
    
    [self.startDateField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(5);
        make.centerY.equalTo(nameLabel);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, 28));
    }];
    
    [self.endDateField mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(self.startDateField.mas_right).offset(30);
        make.right.offset(-18);
        make.centerY.equalTo(nameLabel);
        make.size.equalTo(self.startDateField);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startDateField);
        make.right.equalTo(self.endDateField);
        make.centerY.equalTo(nameLabel2);
        make.height.mas_equalTo(60);
    }];
    
    UIView* line1 = [UILabel new];
    line1.backgroundColor = hexColor(a1a1a1);
    [bgView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startDateField);
        make.height.mas_equalTo(@(0.5));
        make.left.equalTo(self.startDateField.mas_right).offset(5);
        make.right.equalTo(self.endDateField.mas_left).offset(-5);
    }];
    
    [self.startDateField setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                         forAxis:UILayoutConstraintAxisHorizontal];
    [self.endDateField setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                       forAxis:UILayoutConstraintAxisHorizontal];
    [line1 setContentCompressionResistancePriority:UILayoutPriorityRequired
                                           forAxis:UILayoutConstraintAxisHorizontal];
    [nameLabel setContentHuggingPriority:UILayoutPriorityDefaultLow
                                 forAxis:UILayoutConstraintAxisHorizontal];

    UIButton* addBtn = [UIButton new];
    [addBtn blueSolidStyle];
    [addBtn setTitle:@"确定" forState:UIControlStateNormal];
    [bgView addSubview:addBtn];
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-16);
        make.height.mas_equalTo(@(36));
        make.left.equalTo(nameLabel);
        make.right.equalTo(self.endDateField);
    }];
    
    [addBtn addTarget:self action:@selector(addFreeTime) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = hexColor(f5f8fa);
    self.cusnavigationBar.titleLabel.text = @"申请请假";
    
    self.startDateField.delegate = self;
    self.endDateField.delegate = self;
    self.textView.delegate = self;
    
    self.startDateField.tag = 1001;
    self.endDateField.tag = 1002;
    
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textView.layer.cornerRadius = 5;
    
    _startDateField.borderStyle = UITextBorderStyleRoundedRect;
    _endDateField.borderStyle = UITextBorderStyleRoundedRect;
//    _textView.bor = UITextBorderStyleRoundedRect;
    //    _endDateField.layer.borderWidth = _startDateField.layer.borderWidth;
    //    _endDateField.layer.borderColor = _startDateField.layer.borderColor;
    //    _endDateField.layer.cornerRadius = _startDateField.layer.cornerRadius;
    
    //    _startTimeField.layer.borderWidth = _startDateField.layer.borderWidth;
    //    _startTimeField.layer.borderColor = _startDateField.layer.borderColor;
    //    _startTimeField.layer.cornerRadius = _startDateField.layer.cornerRadius;
    //
    //    _endTimeField.layer.borderWidth = _startDateField.layer.borderWidth;
    //    _endTimeField.layer.borderColor = _startDateField.layer.borderColor;
    //    _endTimeField.layer.cornerRadius = _startDateField.layer.cornerRadius;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    //给工具条添加按钮
    UIBarButtonItem *spaceBt = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBt = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dodo)];
    toolBar.items = @[spaceBt,spaceBt,doneBt];
    toolBar.backgroundColor = [UIColor whiteColor];
    
    _startDateField.inputAccessoryView = toolBar;
    _endDateField.inputAccessoryView = toolBar;
    
    _startDateField.inputView = self.datePicker;
    _endDateField.inputView = self.datePicker;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSpace)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch  {
    //    NSLog(@"%@", NSStringFromClass([touch.view class]));
    if ([touch.view isKindOfClass:[YYTextView class]] ||
        [touch.view isKindOfClass:[YYTextContainerView class]]) {
        return NO;
    }
    return  YES;
}

- (void)touchSpace
{
    //    self.maskView.hidden = YES;
    [_startDateField resignFirstResponder];
    [_endDateField resignFirstResponder];
    [_textView resignFirstResponder];
    
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

- (void)addFreeTime
{
    
}

- (YYTextView*)textView
{
    if (!_textView) {
        _textView = [YYTextView new];
        _textView.placeholderText = @"请假事由";
        _textView.placeholderTextColor = rgbfromHex(@"9c9c9c");
        _textView.placeholderFont = Font_System(14);
        _textView.font = Font_System(14);
        _textView.delegate = self;
    }
    return _textView;
}


- (void)textViewDidChange:(YYTextView *)textView
{
    //    if (textView.text.length > MAX_INPUT_NUM) {
    //        textView.text = [textView.text substringWithRange:NSMakeRange(0, MAX_INPUT_NUM)];
    //        [textView.undoManager removeAllActions];
    //        [textView becomeFirstResponder];
    //    }
    
    NSString* value = [NSString stringWithFormat:@"%ld/%d",textView.text.length,MAX_INPUT_NUM];
//    self.wordLabel.text = value;
}

- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""]) {
        return YES;
    }
    
    if (range.location >= MAX_INPUT_NUM)
    {
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 1001 && self.viewModel.endDate) {
        self.datePicker.maximumDate = self.viewModel.endDate;
    }
    if (textField.tag == 1002 && self.viewModel.startDate) {
        self.datePicker.minimumDate = self.viewModel.startDate;
    }
}

- (void)dodo
{
    UITextField* sender = [self firstTextField];
    if (sender) {
        NSString* value = nil;
        if ([sender.inputView isKindOfClass:[UIDatePicker class]]) {
            value = [self.datePicker.date format:@"yyyy-MM-dd"];
            
            if (sender.tag == 1001) {
                self.viewModel.startDate = self.datePicker.date;
            }
            if (sender.tag == 1002) {
                self.viewModel.endDate = self.datePicker.date;
            }
        }
        sender.text  = value;
        [self touchSpace];
    }
}

- (void)chooseDate:(UIDatePicker*)sender
{
    
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//
//    return NO;
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITextField*)startDateField
{
    if (!_startDateField) {
        _startDateField = [UITextField new];
        _startDateField.textAlignment = NSTextAlignmentCenter;
        _startDateField.font = Font_System(12);
        _startDateField.textColor = hexColor(a1a1a1);
    }
    return _startDateField;
}

- (UITextField*)endDateField
{
    if (!_endDateField) {
        _endDateField = [UITextField new];
        _endDateField.textAlignment = NSTextAlignmentCenter;
        _endDateField.font = Font_System(12);
        _endDateField.textColor = hexColor(a1a1a1);
    }
    return _endDateField;
}

- (UIDatePicker*)datePicker
{
    if (!_datePicker) {
        _datePicker = [UIDatePicker new];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.tag = 1009;
        
        //        NSString *dateStr = @"1985-01-01";
        //        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        //        [dateformatter setDateFormat:@"yyyy-MM-dd"];
        //        [LostTimer par]
        NSDate *date = [NSDate date];
        _datePicker.date = date;
        _datePicker.minimumDate = [NSDate date];
        
        double birthDate = [date timeIntervalSince1970];
        NSLog(@"%.2f",birthDate);
        
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        [_datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

@end
