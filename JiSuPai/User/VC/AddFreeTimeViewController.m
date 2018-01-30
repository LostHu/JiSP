//
//  AddFreeTimeViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/21.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "AddFreeTimeViewController.h"

@interface AddFreeTimeViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITextField* startDateField;
@property (nonatomic, strong) UITextField* endDateField;
@property (nonatomic, strong) UITextField* startTimeField;
@property (nonatomic, strong) UITextField* endTimeField;
@property (nonatomic, strong) UIDatePicker* datePicker;
@property (nonatomic, strong) UIPickerView* timePicker;

@end

@implementation AddFreeTimeViewController

- (FreeTimeViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[FreeTimeViewModel alloc] init];
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
    nameLabel2.text = @"时段:";
    nameLabel2.font = Font_System(14);
    [bgView addSubview:nameLabel2];
    [nameLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel).offset(0);
        make.top.equalTo(nameLabel.mas_bottom).offset(28);
    }];
    
    [bgView addSubview: self.startDateField];
    [bgView addSubview: self.endDateField];
    [bgView addSubview: self.startTimeField];
    [bgView addSubview: self.endTimeField];
    
    
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
    
    [self.startTimeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startDateField);
        make.centerY.equalTo(nameLabel2);
        make.size.equalTo(self.startDateField);
    }];
    
    [self.endTimeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.endDateField);
        make.centerY.equalTo(nameLabel2);
        make.size.equalTo(self.startDateField);
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

    UIView* line2 = [UILabel new];
    line2.backgroundColor = hexColor(a1a1a1);
    [bgView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startTimeField);
        make.height.mas_equalTo(@(0.5));
        make.left.right.equalTo(line1);
    }];
    
    [self.startDateField setContentCompressionResistancePriority:UILayoutPriorityRequired
                             forAxis:UILayoutConstraintAxisHorizontal];
    [self.endDateField setContentCompressionResistancePriority:UILayoutPriorityRequired
                                           forAxis:UILayoutConstraintAxisHorizontal];
    [line1 setContentCompressionResistancePriority:UILayoutPriorityRequired
                                           forAxis:UILayoutConstraintAxisHorizontal];
    [nameLabel setContentHuggingPriority:UILayoutPriorityDefaultLow
                             forAxis:UILayoutConstraintAxisHorizontal];
//    [self.startDateField setContentCompressionResistancePriority:UILayoutPriorityRequired
//                                             forAxis:UILayoutConstraintAxisHorizontal];
//    nameLabel.backgroundColor = RandomColor;
//    line1.backgroundColor = RandomColor;
//    self.startDateField.backgroundColor = RandomColor;
//    self.endDateField.backgroundColor = RandomColor;
    
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
    self.cusnavigationBar.titleLabel.text = @"上报空闲时间";
    
    self.startDateField.delegate = self;
    self.endDateField.delegate = self;
    self.startTimeField.delegate = self;
    self.endTimeField.delegate = self;
    
    self.startDateField.tag = 1001;
    self.endDateField.tag = 1002;
    self.startTimeField.tag = 2001;
    self.endTimeField.tag = 2002;

//    _startDateField.layer.borderWidth = 1;
//    _startDateField.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    _startDateField.layer.cornerRadius = 5;
    
    _startDateField.borderStyle = UITextBorderStyleRoundedRect;
    _endDateField.borderStyle = UITextBorderStyleRoundedRect;
    _startTimeField.borderStyle = UITextBorderStyleRoundedRect;
    _endTimeField.borderStyle = UITextBorderStyleRoundedRect;
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
    _startTimeField.inputAccessoryView = toolBar;
    _endTimeField.inputAccessoryView = toolBar;
    
    _startDateField.inputView = self.datePicker;
    _endDateField.inputView = self.datePicker;
    _startTimeField.inputView = self.timePicker;
    _endTimeField.inputView = self.timePicker;
    
    self.startDateField.text = [self.viewModel.startDate format:@"yyyy-MM-dd"];
    self.endDateField.text = [self.viewModel.endDate format:@"yyyy-MM-dd"];
    
    self.startTimeField.text = [self.viewModel.startDate format:@"HH:00"];
    self.endTimeField.text = [self.viewModel.startDate format:@"HH:00"];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSpace)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)touchSpace
{
//    self.maskView.hidden = YES;
    [_startDateField resignFirstResponder];
    [_startTimeField resignFirstResponder];
    [_endDateField resignFirstResponder];
    [_endTimeField resignFirstResponder];

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
    if (self.startTimeField.isFirstResponder) {
        return self.startTimeField;
    }
    if (self.endTimeField.isFirstResponder) {
        return self.endTimeField;
    }
    return nil;
}

- (void)addFreeTime
{
    if (self.viewModel) {
        @weakify(self);
        [self.viewModel addFreeTime:^(id data, BOOL isTodo) {
            @strongify(self);
            if (isTodo == YES) {
                [self touchSpace];
                [HUD showMsg:@"增加空闲时间成功！" type:HUDMsgType_Success];
                [self performSelector:@selector(sendSuccess) withObject:nil afterDelay:0.6];
            }else{
            }
        }];
    }
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
        else
        {
            value = FormatStr(@"%@:%@",[self.viewModel.arrayHour objectAtIndex:[self.timePicker selectedRowInComponent:0]],[self.viewModel.arrayMin objectAtIndex:[self.timePicker selectedRowInComponent:1]]);
            
            if (sender.tag == 2001) {
                self.viewModel.startTime = value;
            }
            if (sender.tag == 2002) {
                self.viewModel.endTime = value;
            }
        }
        NSLog(@"value:%@",value);
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

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.viewModel.arrayHour.count;
    }
    if (component == 1) {
        return self.viewModel.arrayMin.count;
    }
    return 0;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED
{
    if (component == 0) {
        return [self.viewModel.arrayHour objectAtIndex:row];
    }
    if (component == 1) {
        return [self.viewModel.arrayMin objectAtIndex:row];
    }
    return nil;
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

- (UITextField*)startTimeField
{
    if (!_startTimeField) {
        _startTimeField = [UITextField new];
        _startTimeField.textAlignment = NSTextAlignmentCenter;
        _startTimeField.font = Font_System(12);
        _startTimeField.textColor = hexColor(a1a1a1);
    }
    return _startTimeField;
}

- (UITextField*)endTimeField
{
    if (!_endTimeField) {
        _endTimeField = [UITextField new];
        _endTimeField.textAlignment = NSTextAlignmentCenter;
        _endTimeField.font = Font_System(12);
        _endTimeField.textColor = hexColor(a1a1a1);
    }
    return _endTimeField;
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

- (UIPickerView*)timePicker
{
    if (!_timePicker) {
        _timePicker = [UIPickerView new];
        _timePicker.tag = 1008;
        _timePicker.backgroundColor = [UIColor whiteColor];
        _timePicker.delegate = self;
        _timePicker.dataSource = self;
    }
    return _timePicker;
}

@end
