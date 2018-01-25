//
//  InputViewTableViewCell.h
//  Lust
//
//  Created by Lost on 16/4/13.
//  Copyright © 2016年 Lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputViewTableViewCell : UITableViewCell
//@property (nonatomic,strong) RACSubject *delegatedfgSignal;

@property (strong,nonatomic,readwrite) UIToolbar *inputAccessoryView;
//@property (strong,nonatomic,readwrite) UIPickerView *inputView;
@end
