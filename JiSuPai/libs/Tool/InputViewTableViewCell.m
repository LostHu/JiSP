//
//  InputViewTableViewCell.m
//  Lust
//
//  Created by Lost on 16/4/13.
//  Copyright © 2016年 Lost. All rights reserved.
//

#import "InputViewTableViewCell.h"

@implementation InputViewTableViewCell

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)dealloc
{
    _inputAccessoryView = nil;
}

-(UIToolbar *)inputAccessoryView
{
    if(!_inputAccessoryView)
    {
//        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//        
//        //给工具条添加按钮
//        UIBarButtonItem *spaceBt = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//        UIBarButtonItem *doneBt = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dodo)];
//        toolBar.items = @[spaceBt,spaceBt,doneBt];
//        
//        return toolBar;
    }
    return _inputAccessoryView;
}
//-(UIPickerView *)inputView
//{
//    if(!_inputView)
//    {
//        UIPickerView *  pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 200)];
//        pickView.delegate =self;
//        pickView.dataSource = self;
//        pickView.showsSelectionIndicator = YES;
//        return pickView;
//    }
//    return _inputView;
//}

//-(void)dodo
//{
//    if (self.delegatedfgSignal) {
//        [self.delegatedfgSignal sendNext:@"done"];
//    }
//    [self resignFirstResponder];
//}
//
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//}
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return [NSString stringWithFormat:@"%ld",(long)row];
//}
//
//// returns the # of rows in each component..
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    return 5;
//}

@end
