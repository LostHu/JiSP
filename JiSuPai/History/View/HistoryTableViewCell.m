//
//  HistoryTableViewCell.m
//  JiSuPai
//
//  Created by Lost on 2018/1/19.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell

#define HistoryTag 500
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
        
        [self.bgView addSubview:self.codeLabel];
        
        [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.left.offset(10);
        }];
        
        UILabel* name1Label = [self newTitleLabel];
        name1Label.text = @"联系人:";
        [self.bgView addSubview:name1Label];
        
        [name1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.codeLabel.mas_right).offset(5);
            make.centerY.equalTo(self.codeLabel).offset(0);
        }];
        
        UILabel* value1Label = [self newValueLabel];
        value1Label.tag = HistoryTag + 1;
        [self.bgView addSubview:value1Label];
        
        [value1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label.mas_right).offset(5);
            make.centerY.equalTo(name1Label).offset(0);
        }];
        
        UILabel* name9Label = [self newTitleLabel];
        name9Label.text = @"配送日期";
        [self.bgView addSubview:name9Label];
        
        [name9Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.codeLabel);
            make.top.equalTo(self.codeLabel.mas_bottom).offset(6);
            make.bottom.offset(-8);
        }];
        
        UILabel* value9Label = [self newValueLabel];
        value9Label.tag = HistoryTag + 9;
        [self.bgView addSubview:value9Label];
        
        [value9Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name9Label.mas_right).offset(5);
            make.centerY.equalTo(name9Label).offset(0);
        }];
    }
    return self;
}

- (void)setData:(TaskData *)data
{
    self.codeLabel.text = data.customername;
    [self labelForTag:HistoryTag+1].text = FormatStr(@"%@(%@)",data.fahuoren,data.fahuophone) ;
    [self labelForTag:HistoryTag+9].text = data.datedescrip;//FormatStr(@"%@到%@",data.startdate,data.enddate);
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

- (UILabel*)labelForTag:(NSInteger)tag
{
    return [self.bgView viewWithTag:tag];
}

- (UILabel*)codeLabel
{
    if (!_codeLabel) {
        _codeLabel = [UILabel new];
        _codeLabel.textColor = hexColor(605bf7);
        _codeLabel.font = Font_System(12);
    }
    return _codeLabel;
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
@end

@implementation HistorySubTableViewCell

#define HistorySubTag 500
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
        
        UILabel* name9Label = [self newTitleLabel];
        name9Label.text = @"运单日期";
        [self.bgView addSubview:name9Label];
        
        [name9Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.offset(10);
        }];
        
        UILabel* value9Label = [self newValueLabel];
        value9Label.tag = HistorySubTag + 9;
        [self.bgView addSubview:value9Label];
        
        [value9Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name9Label.mas_right).offset(5);
            make.centerY.equalTo(name9Label).offset(0);
        }];
        
        UILabel* name10Label = [self newTitleLabel];
        name10Label.text = @"金额";
        [self.bgView addSubview:name10Label];
        
        [name10Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name9Label);
            make.top.equalTo(name9Label.mas_bottom).offset(5);
            make.bottom.offset(-8);
        }];
        
        UILabel* value10Label = [self newValueLabel];
        value10Label.tag = HistorySubTag + 10;
        [self.bgView addSubview:value10Label];
        
        [value10Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value9Label);
            make.centerY.equalTo(name10Label).offset(0);
        }];
    }
    return self;
}

- (void)setData:(TaskData *)data
{
    [self labelForTag:HistorySubTag+10].text = FormatStr(@"%.2f",data.lastprice);
    [self labelForTag:HistorySubTag+9].text = data.orderdate;
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

- (UILabel*)labelForTag:(NSInteger)tag
{
    return [self.bgView viewWithTag:tag];
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


@end
