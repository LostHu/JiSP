//
//  TaskTableViewCell.m
//  JiSuPai
//
//  Created by Lost on 2018/1/13.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TaskTableViewCell.h"

@implementation TaskTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView* bgView = [UIView new];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = 8;
        bgView.clipsToBounds = YES;
        [self.contentView addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(8, 6, 0, 6));
        }];
        
        [bgView addSubview:self.titleLabel];
        [bgView addSubview:self.phoneBtn];
        [bgView addSubview:self.stateLabel];
        [bgView addSubview:self.startLabel];
        [bgView addSubview:self.areaLabel];
        
        [bgView addSubview:self.dateLabel];
        [bgView addSubview:self.timeLabel];
        [bgView addSubview:self.infoBtn];
        [bgView addSubview:self.okBtn];
        [bgView addSubview:self.stateBtn];

        self.titleLabel.text = @"title";
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView.mas_left).offset(50);
            make.top.offset(9);
        }];
        
        [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.equalTo(bgView).offset(-10);
        }];
        
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.equalTo(self.titleLabel.mas_right).offset(8);
        }];
        
        [self.stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.equalTo(self.titleLabel.mas_right).offset(8);
            make.height.mas_equalTo(@(16));
            make.width.mas_greaterThanOrEqualTo(80);
        }];
        
        UIView* lineView = [UIView new];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [bgView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(7);
            make.left.offset(8);
            make.right.offset(-8);
            make.height.mas_equalTo(@(0.5));
        }];
        
        UILabel* nameStartLabel = [UILabel new];
        nameStartLabel.text = @"出发地点";
        nameStartLabel.font = Font_System(10);
        nameStartLabel.textColor = hexColor(a1a1a1);
        [bgView addSubview:nameStartLabel];
        [nameStartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineView).offset(1);
            make.top.equalTo(lineView).offset(10);
        }];
        
        [self.startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).offset(-3);
            make.centerY.equalTo(nameStartLabel);
            make.left.equalTo(nameStartLabel.mas_right).offset(20);
        }];
        
        UILabel* nameAreaLabel = [UILabel new];
        nameAreaLabel.text = @"配送区域";
        nameAreaLabel.font = Font_System(10);
        nameAreaLabel.textColor = hexColor(a1a1a1);
        [bgView addSubview:nameAreaLabel];
        [nameAreaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameStartLabel);
            make.top.equalTo(nameStartLabel.mas_bottom).offset(8);
        }];
        
        [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameAreaLabel);
            make.left.equalTo(self.startLabel);
        }];
        
        UILabel* nameDateLabel = [UILabel new];
        nameDateLabel.text = @"运单日期";
        nameDateLabel.font = Font_System(10);
        nameDateLabel.textColor = hexColor(a1a1a1);
        [bgView addSubview:nameDateLabel];
        [nameDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameStartLabel);
            make.top.equalTo(nameAreaLabel.mas_bottom).offset(8);
        }];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameDateLabel);
            make.left.equalTo(self.startLabel);
        }];
        
        UILabel* nameTimeLabel = [UILabel new];
        nameTimeLabel.text = @"到岗时间";
        nameTimeLabel.font = Font_System(10);
        nameTimeLabel.textColor = hexColor(a1a1a1);
        [bgView addSubview:nameTimeLabel];
        [nameTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameStartLabel);
            make.top.equalTo(nameDateLabel.mas_bottom).offset(8);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameTimeLabel);
            make.left.equalTo(self.startLabel);
        }];
        
        [self.infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView).multipliedBy(0.6);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.36, 22));
            make.bottom.offset(-8);
        }];
        
        [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView).multipliedBy(1.4);
            make.size.bottom.equalTo(self.infoBtn);
        }];
    }
    return self;
}

- (void)setData:(TaskData *)data
{
    _data = data;
    self.titleLabel.text = data.customername;
    self.dateLabel.text = data.orderdate;
    self.timeLabel.text = data.daogangtime;
    self.areaLabel.text = data.peisongquyu;
    self.startLabel.text = data.fahuoaddress;
//    self.stateLabel.text = data.orderstatusInCn;
    [self.stateBtn setTitle:data.orderstatusInCn forState:UIControlStateNormal];
//    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:data.orderstatusInCn];
//    YYTextContainer* container = [YYTextContainer new];
//    str.font = Font_System(12);
//    container.insets = UIEdgeInsetsMake(5, 15, 5, 15);
//    YYTextLayout *sourceTextLayout = [YYTextLayout layoutWithContainer:container text:str];
//    _stateLabel.textLayout = sourceTextLayout;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"33";
        _titleLabel.textColor = hexColor(605bf7);
        _titleLabel.font = Font_System_Bold(12);
        _titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _titleLabel;
}

- (YYLabel*)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [YYLabel new];
        _stateLabel.text = @"33";
        _stateLabel.textColor = hexColor(605bf7);
        _stateLabel.font = Font_System(12);
        _stateLabel.backgroundColor = hexColor(fcd45a);
        _stateLabel.layer.cornerRadius = 10;
        _stateLabel.clipsToBounds = YES;
        NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"33"];
        YYTextContainer* container = [YYTextContainer new];
        str.font = Font_System(12);
        container.insets = UIEdgeInsetsMake(5, 15, 5, 15);
        YYTextLayout *sourceTextLayout = [YYTextLayout layoutWithContainer:container text:str];
        _stateLabel.textLayout = sourceTextLayout;
    }
    return _stateLabel;
}

- (UILabel*)startLabel
{
    if (!_startLabel) {
        _startLabel = [UILabel new];
        _startLabel.text = @"33";
        _startLabel.textColor = hexColor(000000);
        _startLabel.font = Font_System(12);
    }
    return _startLabel;
}

- (UILabel*)areaLabel
{
    if (!_areaLabel) {
        _areaLabel = [UILabel new];
        _areaLabel.text = @"33";
        _areaLabel.textColor = hexColor(000000);
        _areaLabel.font = Font_System(12);
    }
    return _areaLabel;
}

- (UILabel*)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.text = @"33";
        _dateLabel.textColor = hexColor(000000);
        _dateLabel.font = Font_System(12);
    }
    return _dateLabel;
}

- (UILabel*)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.text = @"33";
        _timeLabel.textColor = hexColor(000000);
        _timeLabel.font = Font_System(12);
    }
    return _timeLabel;
}

- (UIButton*)phoneBtn
{
    if (!_phoneBtn) {
        _phoneBtn = [UIButton new];
        [_phoneBtn setImage:ImageNamed(@"pic_libao") forState:UIControlStateNormal];
    }
    return _phoneBtn;
}

- (UIButton*)infoBtn
{
    if (!_infoBtn) {
        _infoBtn = [UIButton new];
        [_infoBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [_infoBtn solidStyleforC:hexColor(557ef4) D:[UIColor lightGrayColor] font:Font_System(12) corner:3];
        [_infoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _infoBtn;
}

- (UIButton*)stateBtn
{
    if (!_stateBtn) {
        _stateBtn = [UIButton new];
        [_stateBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [_stateBtn solidStyleforC:hexColor(fcd45a) D:[UIColor lightGrayColor] font:Font_System_Bold(10) corner:8];
        [_stateBtn setTitleColor:hexColor(a38a39) forState:UIControlStateNormal];
//        [_stateBtn setTitleEdgeInsets:UIEdgeInsetsMake(2, 8, 2, 8)];
//        _stateLabel.textColor = hexColor(605bf7);
//        _stateLabel.font = Font_System(12);
//        _stateLabel.backgroundColor = hexColor(fcd45a);
//        _stateLabel.layer.cornerRadius = 10;
    }
    return _stateBtn;
}

- (UIButton*)okBtn
{
    if (!_okBtn) {
        _okBtn = [UIButton new];
        [_okBtn setTitle:@"完成工作" forState:UIControlStateNormal];
        [_okBtn solidStyleforC:hexColor(fdd55b) D:[UIColor lightGrayColor] font:Font_System(12) corner:3];
        [_okBtn setTitleColor:hexColor(a38a39) forState:UIControlStateNormal];
    }
    return _okBtn;
}

@end
