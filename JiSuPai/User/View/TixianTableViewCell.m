//
//  TixianTableViewCell.m
//  JiSuPai
//
//  Created by Lost on 2018/2/8.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TixianTableViewCell.h"

@implementation TixianTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bgView.layer.cornerRadius = 8;
        [self.contentView addSubview:self.bgView];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(6, 6, 0, 6));
        }];
        
        [self.bgView addSubview: self.dateLabel];
        [self.bgView addSubview: self.sqjeLabel];
        [self.bgView addSubview: self.tixianLabel];
        [self.bgView addSubview: self.descLabel];
        [self.bgView addSubview: self.stateBtn];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.offset(10);
        }];
        
        [self.stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.dateLabel).offset(0);
            make.right.offset(-12);
            make.size.mas_equalTo(CGSizeMake(50,20));
        }];
        
        [self.sqjeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dateLabel);
            make.top.equalTo(self.dateLabel.mas_bottom).offset(8);
        }];
        
        [self.tixianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sqjeLabel.mas_right).offset(10);
            make.centerY.equalTo(self.sqjeLabel);
        }];
        
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dateLabel);
            make.top.equalTo(self.sqjeLabel.mas_bottom).offset(8);
            make.bottom.offset(-10);
        }];
    }
    return self;
}

- (UIView*)bgView
{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10;
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}

- (UIButton*)stateBtn
{
    if (!_stateBtn) {
        _stateBtn = [UIButton new];
        _stateBtn.userInteractionEnabled = NO;
        [_stateBtn solidStyleforC:hexColor(fcd45a) D:[UIColor lightGrayColor] font:Font_System_Bold(11) corner:10];
        [_stateBtn setTitleColor:hexColor(a38a39) forState:UIControlStateNormal];
    }
    return _stateBtn;
}

- (UILabel*)sqjeLabel
{
    if (!_sqjeLabel) {
        _sqjeLabel = [UILabel new];
        _sqjeLabel.textColor = hexColor(a1a1a1);
        _sqjeLabel.font = Font_System(12);
    }
    return _sqjeLabel;
}

- (UILabel*)tixianLabel
{
    if (!_tixianLabel) {
        _tixianLabel = [UILabel new];
        _tixianLabel.textColor = hexColor(a1a1a1);
        _tixianLabel.font = Font_System(12);
    }
    return _tixianLabel;
}

- (UILabel*)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.text = @"33";
        _dateLabel.textColor = hexColor(111111);
        _dateLabel.font = Font_System_Bold(14);
    }
    return _dateLabel;
}

- (UILabel*)descLabel
{
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.text = @"33";
        _descLabel.textColor = hexColor(a1a1a1);
        _descLabel.font = Font_System(12);
    }
    return _descLabel;
}

@end
