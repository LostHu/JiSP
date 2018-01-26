//
//  FreeTimeTableViewCell.m
//  JiSuPai
//
//  Created by Lost on 2018/1/21.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "FreeTimeTableViewCell.h"

@implementation FreeTimeTableViewCell

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
        
        UILabel* nameLabel = [UILabel new];
        nameLabel.textColor = hexColor(a1a1a1);
        nameLabel.text = @"日期:";
        nameLabel.font = Font_System(12);
        [self.bgView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(8);
            make.top.offset(8);
        }];
        
        UILabel* nameLabel2 = [UILabel new];
        nameLabel2.textColor = hexColor(a1a1a1);
        nameLabel2.text = @"时段:";
        nameLabel2.tag = 1980;
        nameLabel2.font = Font_System(12);
        [self.bgView addSubview:nameLabel2];
        [nameLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel).offset(0);
            make.bottom.offset(-8);
        }];
        //
        //        [self.contentView addSubview:self.editBtn];
        //        [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.centerY.equalTo(nameLabel);
        //            make.right.offset(-12);
        //            make.size.mas_equalTo(CGSizeMake(24, 24));
        //        }];
        
        [self.bgView addSubview: self.dateLabel];
        [self.bgView addSubview: self.timeLabel];
        [self.bgView addSubview: self.delBtn];
        
        [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bgView).offset(0);
            //            make.centerY.equalTo(self.contentView).offset(-15);
            make.right.offset(-20);
            make.size.mas_equalTo(CGSizeMake(20,20));
        }];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.mas_right).offset(10);
            make.centerY.equalTo(nameLabel);
        }];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dateLabel);
            make.centerY.equalTo(nameLabel2);
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

- (UIButton*)delBtn
{
    if (!_delBtn) {
        _delBtn = [UIButton new];
        [_delBtn setImage:ImageNamed(@"icon_jian") forState:UIControlStateNormal];
    }
    return _delBtn;
}

- (UILabel*)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.text = @"33";
        _dateLabel.textColor = hexColor(111111);
        _dateLabel.font = Font_System(12);
    }
    return _dateLabel;
}

- (UILabel*)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.text = @"33";
        _timeLabel.textColor = hexColor(111111);
        _timeLabel.font = Font_System(12);
    }
    return _timeLabel;
}
@end
