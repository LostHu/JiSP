//
//  ExceptionWorkingViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/28.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "ExceptionWorkingViewController.h"

#define MAX_INPUT_NUM 500

@interface ExceptionWorkingViewController ()<UIPickerViewDelegate,UITextFieldDelegate,YYTextViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITextField* startDateField;
@property (nonatomic, strong) YYTextView* textView;
@property (nonatomic, strong) UIPickerView* timePicker;

@end

@implementation ExceptionWorkingViewController

- (WorkingViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[WorkingViewModel alloc] init];
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
        make.height.mas_equalTo(@(180));
    }];
    
    UILabel* nameLabel = [UILabel new];
    nameLabel.textColor = hexColor(111111);
    nameLabel.text = @"类型:";
    nameLabel.font = Font_System(14);
    [bgView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(18);
        make.top.offset(18);
        make.width.mas_equalTo(@(40));
    }];
    
    UILabel* nameLabel2 = [UILabel new];
    nameLabel2.textColor = hexColor(111111);
    nameLabel2.text = @"异常\n说明:";
    nameLabel2.font = Font_System(14);
    nameLabel2.numberOfLines = 2;
    [bgView addSubview:nameLabel2];
    [nameLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel).offset(0);
        make.top.equalTo(nameLabel.mas_bottom).offset(32);
    }];
    
    [bgView addSubview: self.startDateField];
    [bgView addSubview: self.textView];
    
    
    [self.startDateField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(5);
        make.right.offset(-18);
        make.centerY.equalTo(nameLabel);
        make.height.mas_equalTo(28);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.startDateField);
        make.centerY.equalTo(nameLabel2);
        make.height.mas_equalTo(60);
    }];
  
    
    UIButton* addBtn = [UIButton new];
    [addBtn blueSolidStyle];
    [addBtn setTitle:@"确定" forState:UIControlStateNormal];
    [bgView addSubview:addBtn];
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-16);
        make.height.mas_equalTo(@(36));
        make.left.equalTo(nameLabel);
        make.right.equalTo(self.startDateField);
    }];
    
    [addBtn addTarget:self action:@selector(addException) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = hexColor(f5f8fa);
    self.cusnavigationBar.titleLabel.text = @"异常上报";
    
    self.startDateField.delegate = self;
    self.textView.delegate = self;
    
    self.startDateField.tag = 1001;
    
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = hexColor(ebeaeb).CGColor;
    _textView.layer.cornerRadius = 5;
    
    _startDateField.borderStyle = UITextBorderStyleRoundedRect;
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
    
    _startDateField.inputView = self.timePicker;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSpace)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    [self.viewModel getWorkingExceptionData:^(id data, BOOL isTodo) {
        
    }];
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
    [_startDateField resignFirstResponder];
    [_textView resignFirstResponder];
    
    [self.view endEditing:YES];
}

- (void)sendSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addException
{
    NSString* value = self.startDateField.text;
    if ([NSString isBlankString:value]) {
        [HUD showMsg:@"异常类型不能为空"];
        return;
    }
    
    NSString* value2 = self.textView.text;
//    if ([NSString isBlankString:value2]) {
//        [HUD showMsg:@"异常类型不能为空"];
//        return;
//    }
    @weakify(self);
    [self.viewModel addWorkingExceptionType:value desc:value2 block:^(id data, BOOL isTodo) {
        if (isTodo) {
            @strongify(self);
            [HUD showMsg:@"上报成功"];
            [self performSelector:@selector(sendSuccess) withObject:nil afterDelay:1.5];
        }
    }];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.viewModel.arrayException.count;
    }
    return 0;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED
{
    if (component == 0) {
        return [self.viewModel.arrayException objectAtIndex:row];
    }
    return nil;
}

- (YYTextView*)textView
{
    if (!_textView) {
        _textView = [YYTextView new];
        _textView.placeholderText = @"异常说明";
        _textView.placeholderTextColor = rgbfromHex(@"9c9c9c");
        _textView.placeholderFont = Font_System(12);
        _textView.font = Font_System(12);
        _textView.textColor = hexColor(a1a1a1);
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

- (void)dodo
{
    UITextField* sender = [self startDateField];
    if (sender) {
        NSString* value = nil;
        if ([sender.inputView isKindOfClass:[UIPickerView class]]) {
            value = FormatStr(@"%@",[self.viewModel.arrayException objectAtIndex:[self.timePicker selectedRowInComponent:0]]);
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
