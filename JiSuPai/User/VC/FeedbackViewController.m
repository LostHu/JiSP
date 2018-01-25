//
//  FeedbackViewController.m
//  GameBiBi
//
//  Created by Lost on 2017/7/19.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import "FeedbackViewController.h"

#define MAX_INPUT_NUM 500

@interface FeedbackViewController ()<YYTextViewDelegate>
@property (nonatomic, strong) YYTextView* textView;
@property (nonatomic, strong) YYLabel* wordLabel;
@end

@implementation FeedbackViewController

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textView];
    [self.view addSubview:self.wordLabel];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationBarHeight + 6);
        make.left.equalTo(self.view).offset(8);
        make.right.equalTo(self.view).offset(-8);
        make.height.mas_equalTo(@(180));
    }];
    
    [self.wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.textView);
        make.top.equalTo(self.textView.mas_bottom).offset(5);
    }];
    
    self.cusnavigationBar.titleLabel.text = @"意见建议";
    [self.cusnavigationBar.rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.cusnavigationBar.rightButton setTitleColor:rgbfromHex(@"06b0ff") forState:UIControlStateNormal];
    [self.cusnavigationBar.rightButton setTitleColor:rgbfromHex(@"456789") forState:UIControlStateHighlighted];
    self.cusnavigationBar.rightButton.titleLabel.font = Font_System(14);
    self.cusnavigationBar.rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [[self.cusnavigationBar.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (self.textView.text.length > MAX_INPUT_NUM) {
            [HUD showMsg:@"您输入超过最大长度，请删除后再试"];
        }
        else {
            
            NSString* value = [NSString trimWhitespaceAndNewline:self.textView.text];
            
            if ([NSString isBlankString:value]) {
                [HUD showMsg:@"输入不能为空"];
                return;
            }
            
            if ([NSString stringContainsEmoji:value]) {
                [HUD showMsg:@"意见建议无法使用使用表情"];
                return;
            }
            
            NSMutableDictionary* param = [NSMutableDictionary dictionary];
            [param setObject:self.textView.text forKey:@"fankui"];
            [LostHttpClient GETRequestURL:API_Feedback WithParameter:param WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
                @strongify(self);
                if ([returnValue[@"result"] isEqualToString:@"true"]) {
                    [self.textView endEditing:YES];
                    [HUD showMsg:@"感谢您提出的建议，我们会尽快改进！" type:HUDMsgType_Success];
                    [self performSelector:@selector(sendSuccess) withObject:nil afterDelay:0.6];
                }else{
                    [HUD showMsg:appendData.msg type: HUDMsgType_Error];
                }
            } WithFailureBlock:^{
                
            }];
        }
    }];
}

- (void)dealloc
{
    _textView.delegate = nil;
    _textView = nil;
    _wordLabel = nil;
    DDLog(@"dealloc-basevc %@",self.className);
}

- (void)sendSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)textViewDidChange:(YYTextView *)textView
{
//    if (textView.text.length > MAX_INPUT_NUM) {
//        textView.text = [textView.text substringWithRange:NSMakeRange(0, MAX_INPUT_NUM)];
//        [textView.undoManager removeAllActions];
//        [textView becomeFirstResponder];
//    }
    
    NSString* value = [NSString stringWithFormat:@"%ld/%d",textView.text.length,MAX_INPUT_NUM];
    self.wordLabel.text = value;
}

- (YYTextView*)textView
{
    if (!_textView) {
        _textView = [YYTextView new];
        _textView.placeholderText = @"请写下您对我们的改进要求";
        _textView.placeholderTextColor = rgbfromHex(@"9c9c9c");
        _textView.placeholderFont = Font_System(14);
        _textView.font = Font_System(14);
        _textView.delegate = self;
    }
    return _textView;
}

- (YYLabel*)wordLabel
{
    if (!_wordLabel) {
        _wordLabel = [YYLabel new];
        _wordLabel.textColor = rgbfromHex(@"cccccc");
        _wordLabel.font = Font_System(13);
        _wordLabel.text = [NSString stringWithFormat:@"0/%d",MAX_INPUT_NUM];
    }
    return _wordLabel;
}

@end
