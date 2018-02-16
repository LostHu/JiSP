//
//  TaskDateBarView.m
//  JiSuPai
//
//  Created by Lost on 2018/1/13.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TaskDateBarView.h"

@implementation TaskDateBarView

- (id)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.selBtn];
        [self addSubview:self.dayLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.dateBtn];
        self.dayLabel.text = @"所有";
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self).multipliedBy(0.36);
//            make.width.equalTo(self).multipliedBy(0.2);
//            make.height.equalTo(self).multipliedBy(0.5);
            make.size.mas_equalTo(CGSizeMake(20, 16));
        }];
        
        [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.selBtn.mas_left).offset(2);
            make.height.equalTo(self).multipliedBy(0.5);
        }];
        
        [self.dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self).multipliedBy(1.65);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
//        @weakify(self);
//        [RACObserve(self, timeStamp) subscribeNext:^(id x) {
//            @strongify(self);
//            if (x && [x isKindOfClass:[NSNumber class]]) {
//                self.titleLabel.text = [LostTimer parseDate:[x integerValue]];
//            }
//        }];
    }
    return self;
}

- (UIButton*)dateBtn
{
    if (!_dateBtn) {
        _dateBtn = [UIButton new];
        [_dateBtn setImage:ImageNamed(@"日期") forState:UIControlStateNormal];
    }
    return _dateBtn;
}


- (UIButton*)selBtn
{
    if (!_selBtn) {
        _selBtn = [UIButton new];
        [_selBtn setImage:ImageNamed(@"light_btn拷贝") forState:UIControlStateNormal];
    }
    return _selBtn;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = hexColor(a1a1a1);
        _titleLabel.font = Font_System(13);
    }
    return _titleLabel;
}

- (UILabel*)dayLabel
{
    if (!_dayLabel) {
        _dayLabel = [UILabel new];
        _dayLabel.textColor = hexColor(a1a1a1);
        _dayLabel.font = Font_System(13);
        _dayLabel.textAlignment = NSTextAlignmentRight;
        _dayLabel.userInteractionEnabled = YES;
    }
    return _dayLabel;
}
@end
