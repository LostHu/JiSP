//
//  MyCarBaseTableViewCell.m
//  JiSuPai
//
//  Created by Lost on 2018/1/29.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "MyCarBaseTableViewCell.h"

@implementation MyCarBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        [self.contentView addSubview:self.indexLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.lineView];
        
        self.titleLabel.text = @"title";
        self.indexLabel.layer.cornerRadius = 8;
        self.indexLabel.font = Font_System(12);
        self.indexLabel.clipsToBounds = YES;
        [self.indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(15);
            make.left.offset(17);
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.indexLabel);
            make.left.equalTo(self.indexLabel.mas_right).offset(5);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(40);
            make.left.equalTo(self.titleLabel).offset(0);
            make.right.offset(-25);
            make.height.mas_equalTo(@(0.5));
        }];
    }
    return self;
}

- (UILabel*)newTitleLabel
{
    UILabel* label = [UILabel new];
    label.textColor = hexColor(a1a1a1);
    label.font = Font_System(10);
    return label;
}

- (UILabel*)newValueLabel
{
    UILabel* label = [UILabel new];
    label.textColor = hexColor(111111);
    label.font = Font_System(10);
    return label;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = hexColor(111111);
        _titleLabel.font = Font_System(12);
        _titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _titleLabel;
}

- (UILabel*)indexLabel
{
    if (!_indexLabel) {
        _indexLabel = [UILabel new];
        _indexLabel.text = @"0";
        _indexLabel.textColor = hexColor(ffffff);
        _indexLabel.font = Font_System(12);
        _indexLabel.backgroundColor = hexColor(999999);
        _indexLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _indexLabel;
}

- (UIView*)lineView
{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = hexColor(eeeeee);
    }
    return _lineView;
}

@end

@implementation MyCarPhotoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        [self.contentView addSubview:self.sfz1Btn];
        [self.contentView addSubview:self.sfz2Btn];
        [self.contentView addSubview:self.infoLabel1];
        [self.contentView addSubview:self.infoLabel2];
        
        [self.sfz1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineView.mas_bottom).offset(12);
            make.left.equalTo(self.lineView).offset(5);
//            161              103
//            SCREEN_WIDTH/3.2 80
            
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3.2, (SCREEN_WIDTH/3.2)*103/161));
        }];
        
        [self.sfz2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.top.equalTo(self.sfz1Btn);
            make.right.equalTo(self.lineView).offset(-15);
        }];
        
        [self.infoLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sfz1Btn.mas_bottom).offset(5);
            make.centerX.equalTo(self.sfz1Btn).offset(0);
        }];
        
        [self.infoLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.infoLabel1);
            make.centerX.equalTo(self.sfz2Btn).offset(0);
        }];
    }
    return self;
}

- (UIButton*)sfz1Btn
{
    if (!_sfz1Btn) {
        _sfz1Btn = [UIButton new];
        [_sfz1Btn setBackgroundImage:ImageNamed(@"+") forState:UIControlStateNormal];
    }
    return _sfz1Btn;
}

- (UIButton*)sfz2Btn
{
    if (!_sfz2Btn) {
        _sfz2Btn = [UIButton new];
        [_sfz2Btn setBackgroundImage:ImageNamed(@"+") forState:UIControlStateNormal];
    }
    return _sfz2Btn;
}

- (UILabel*)infoLabel1
{
    if (!_infoLabel1) {
        _infoLabel1 = [UILabel new];
        _infoLabel1.textColor = hexColor(a1a1a1);
        _infoLabel1.font = Font_System(10);
        _infoLabel1.textAlignment = NSTextAlignmentRight;
    }
    return _infoLabel1;
}

- (UILabel*)infoLabel2
{
    if (!_infoLabel2) {
        _infoLabel2 = [UILabel new];
        _infoLabel2.text = @"0";
        _infoLabel2.textColor = hexColor(a1a1a1);
        _infoLabel2.font = Font_System(10);
        _infoLabel2.textAlignment = NSTextAlignmentCenter;
    }
    return _infoLabel2;
}

@end


@implementation MyCarDriverPhotoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        [self.contentView addSubview:self.sfz3Btn];
        [self.contentView addSubview:self.infoLabel3];
        
        [self.sfz3Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.left.equalTo(self.sfz1Btn);
            make.top.equalTo(self.sfz1Btn.mas_bottom).offset(28);
        }];
        
        [self.infoLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sfz3Btn.mas_bottom).offset(5);
            make.centerX.equalTo(self.sfz3Btn).offset(0);
        }];
    }
    return self;
}

- (UIButton*)sfz3Btn
{
    if (!_sfz3Btn) {
        _sfz3Btn = [UIButton new];
        [_sfz3Btn setBackgroundImage:ImageNamed(@"+") forState:UIControlStateNormal];
    }
    return _sfz3Btn;
}
- (UILabel*)infoLabel3
{
    if (!_infoLabel3) {
        _infoLabel3 = [UILabel new];
        _infoLabel3.text = @"0";
        _infoLabel3.textColor = hexColor(a1a1a1);
        _infoLabel3.font = Font_System(10);
        _infoLabel3.textAlignment = NSTextAlignmentCenter;
    }
    return _infoLabel3;
}
@end

