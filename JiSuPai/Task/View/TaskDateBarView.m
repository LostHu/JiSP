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
        [self addSubview:self.titleLabel];
        [self addSubview:self.dateBtn];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self).multipliedBy(0.35);
            make.width.equalTo(self).multipliedBy(0.2);
            make.height.equalTo(self).multipliedBy(0.5);
        }];
        
        [self.dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self).multipliedBy(1.65);
            make.width.equalTo(self).multipliedBy(0.2);
            make.height.equalTo(self).multipliedBy(0.5);
        }];
        
        @weakify(self);
        [RACObserve(self, timeStamp) subscribeNext:^(id x) {
            @strongify(self);
            if (x && [x isKindOfClass:[NSNumber class]]) {
                self.titleLabel.text = [LostTimer parseDate:[x integerValue]];
            }
        }];
    }
    return self;
}

- (UIButton*)dateBtn
{
    if (!_dateBtn) {
        _dateBtn = [UIButton new];
        [_dateBtn setImage:ImageNamed(@"tab_icon_dongtai") forState:UIControlStateNormal];
    }
    return _dateBtn;
}


- (UIButton*)selBtn
{
    if (!_selBtn) {
        _selBtn = [UIButton new];
        [_selBtn setImage:ImageNamed(@"pic_view") forState:UIControlStateNormal];
    }
    return _selBtn;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = hexColor(a1a1a1);
        _titleLabel.font = Font_System(12);
    }
    return _titleLabel;
}

@end
