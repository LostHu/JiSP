//
//  FirstTableViewCell.m
//  JiSuPai
//
//  Created by Lost on 2018/1/17.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell


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
        [bgView addSubview:self.driverEnoughLabel];
        [bgView addSubview:self.codeLabel];
        [bgView addSubview:self.priceLabel];
        [bgView addSubview:self.startLabel];
        [bgView addSubview:self.areaLabel];
        
        
        
        [bgView addSubview:self.dateLabel];
        [bgView addSubview:self.timeLabel];
        [bgView addSubview:self.timeEndLabel];
        [bgView addSubview:self.needCarLabel];
        [bgView addSubview:self.okBtn];
        
        self.titleLabel.text = @"title";
        self.codeLabel.text = @"任务编号";
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView.mas_left).offset(30);
            make.top.offset(9);
        }];
        
        [self.driverEnoughLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.equalTo(self.titleLabel.mas_right).offset(4);
        }];
        
        [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.right.equalTo(bgView).offset(-10);
        }];
        
//        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.titleLabel);
//            make.left.equalTo(self.titleLabel.mas_right).offset(8);
//        }];
        
        UIView* lineView = [UIView new];
        lineView.backgroundColor = hexColor(eeeeee);
        [bgView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
            make.left.offset(8);
            make.right.offset(-8);
            make.height.mas_equalTo(@(0.5));
        }];
        
        UILabel* nameNeedLabel = [UILabel new];
        nameNeedLabel.text = @"要招车型";
        nameNeedLabel.font = Font_System(12);
        nameNeedLabel.textColor = hexColor(a1a1a1);
        [bgView addSubview:nameNeedLabel];
        [nameNeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineView).offset(1);
            make.top.equalTo(lineView).offset(10);
        }];
        
        [self.needCarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameNeedLabel);
            make.left.equalTo(nameNeedLabel.mas_right).offset(10);
        }];
        
        UILabel* nameStartLabel = [UILabel new];
        nameStartLabel.text = @"出发地点";
        nameStartLabel.font = Font_System(12);
        nameStartLabel.textColor = hexColor(a1a1a1);
        [bgView addSubview:nameStartLabel];
        [nameStartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameNeedLabel);
            make.top.equalTo(nameNeedLabel.mas_bottom).offset(8);
        }];
        
        [self.startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameStartLabel);
            make.left.equalTo(self.needCarLabel);
        }];
        
        UILabel* nameAreaLabel = [UILabel new];
        nameAreaLabel.text = @"配送区域";
        nameAreaLabel.font = Font_System(12);
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
        nameDateLabel.text = @"配送日期";
        nameDateLabel.font = Font_System(12);
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
        nameTimeLabel.font = Font_System(12);
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
        
        UILabel* nameTimeEndLabel = [UILabel new];
        nameTimeEndLabel.text = @"预计完成时间";
        nameTimeEndLabel.font = Font_System(12);
        nameTimeEndLabel.textColor = hexColor(a1a1a1);
        [bgView addSubview:nameTimeEndLabel];
        [nameTimeEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLabel.mas_right).offset(10);
            make.top.equalTo(nameDateLabel.mas_bottom).offset(8);
        }];
        
        [self.timeEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameTimeLabel);
            make.left.equalTo(nameTimeEndLabel.mas_right).offset(10);
        }];
        
        UILabel* namePriceLabel = [UILabel new];
        namePriceLabel.text = @"到手价";
        namePriceLabel.font = Font_System(12);
        namePriceLabel.textColor = hexColor(a1a1a1);
        [bgView addSubview:namePriceLabel];
        [namePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameStartLabel);
            make.top.equalTo(nameTimeLabel.mas_bottom).offset(8);
        }];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(namePriceLabel);
            make.left.equalTo(self.startLabel);
        }];
        
        [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
//            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-50, 30));
            make.height.mas_equalTo(@(28));
            make.left.offset(6);
            make.right.offset(-6);
            make.bottom.offset(-8);
        }];
    }
    return self;
}

- (void)setData:(TaskData *)data
{
    _data = data;
    self.dateLabel.text = FormatStr(@"%@ 到 %@",data.startdate,data.enddate); ;
    self.timeLabel.text = data.daogangtime;
    self.timeEndLabel.text = data.costhour;
    self.areaLabel.text = data.peisongquyu;
    self.startLabel.text = data.fahuoaddress;
    self.stateLabel.text = data.orderstatusInCn;
    self.needCarLabel.text = data.cartypeInCn;
    self.titleLabel.text = data.customername;
    self.codeLabel.text = FormatStr(@"任务编号：%@",data.firstorderid);
    self.priceLabel.text = FormatStr(@"约%ld",data.lastprice);
    self.driverEnoughLabel.hidden = (data.driverenough != 1);
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"33";
        _titleLabel.textColor = hexColor(605bf7);
        _titleLabel.font = Font_System_Bold(13);
        _titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _titleLabel;
}

- (UILabel*)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [UILabel new];
        _stateLabel.text = @"33";
        _stateLabel.textColor = hexColor(605bf7);
        _stateLabel.font = Font_System(12);
        _stateLabel.backgroundColor = hexColor(fcd45a);
        _stateLabel.layer.cornerRadius = 10;
        _stateLabel.clipsToBounds = YES;
    }
    return _stateLabel;
}

- (UILabel*)needCarLabel
{
    if (!_needCarLabel) {
        _needCarLabel = [UILabel new];
        _needCarLabel.text = @"33";
        _needCarLabel.textColor = hexColor(000000);
        _needCarLabel.font = Font_System(12);
    }
    return _needCarLabel;
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

- (UILabel*)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.text = @"33";
        _priceLabel.textColor = hexColor(557df2);
        _priceLabel.font = Font_System(12);
    }
    return _priceLabel;
}

- (UILabel*)codeLabel
{
    if (!_codeLabel) {
        _codeLabel = [UILabel new];
        _codeLabel.text = @"33";
        _codeLabel.textColor = hexColor(a1a1a1);
        _codeLabel.font = Font_System(12);
        _codeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _codeLabel;
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
        _dateLabel.textColor = hexColor(000000);
        _dateLabel.font = Font_System(12);
    }
    return _dateLabel;
}

- (UILabel*)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = hexColor(000000);
        _timeLabel.font = Font_System(12);
    }
    return _timeLabel;
}

- (UILabel*)driverEnoughLabel
{
    if (!_driverEnoughLabel) {
        _driverEnoughLabel = [UILabel new];
        _driverEnoughLabel.textColor = [UIColor redColor];
        _driverEnoughLabel.font = Font_System(13);
        _driverEnoughLabel.text = @"(司机已满)";
        _driverEnoughLabel.hidden = YES;
    }
    return _driverEnoughLabel;
}

- (UILabel*)timeEndLabel
{
    if (!_timeEndLabel) {
        _timeEndLabel = [UILabel new];
        _timeEndLabel.textColor = hexColor(000000);
        _timeEndLabel.font = Font_System(12);
    }
    return _timeEndLabel;
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

- (UIButton*)okBtn
{
    if (!_okBtn) {
        _okBtn = [UIButton new];
        [_okBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [_okBtn solidStyleforC:hexColor(5662f6) D:[UIColor lightGrayColor] font:Font_System_Bold(12) corner:4];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _okBtn;
}


@end
