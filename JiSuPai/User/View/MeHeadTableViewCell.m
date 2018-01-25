//
//  MeHeadTableViewCell.m
//  JiSuPai
//
//  Created by Lost on 2018/1/15.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "MeHeadTableViewCell.h"

@implementation MeHeadExtractTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview: self.edBtn];
        [self.contentView addSubview: self.ingBtn];
        [self.contentView addSubview: self.canBtn];
        [self.contentView addSubview: self.confirmBtn];
        
        [self.edBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_right).multipliedBy(0.16);
            make.centerY.equalTo(self.contentView);
        }];
        
        [self.ingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_right).multipliedBy(0.39);
            make.centerY.equalTo(self.contentView);
        }];
        
        [self.canBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_right).multipliedBy(0.61);
            make.centerY.equalTo(self.contentView);
        }];
        
        [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_right).multipliedBy(0.84);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)updateBtn:(UIButton*)btn title:(NSString*)title count:(CGFloat)count
{
    NSString* curr = FormatStr(@"%.1f",count);
    NSString* remain = title;
    NSString *firstString = FormatStr(@"%@\n%@",curr,remain);
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:firstString];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [firstString length])];
    
    [str addAttribute:NSForegroundColorAttributeName value:rgbfromHex(@"ababab") range:NSMakeRange(0,firstString.length)];
    [str addAttribute:NSFontAttributeName value:Font_System_Bold(11) range:NSMakeRange(0,firstString.length)];
    
    NSRange range_curr = [firstString rangeOfString:curr];
    if (range_curr.location != NSNotFound) {
        [str addAttribute:NSForegroundColorAttributeName value:rgbfromHex(@"5174f7") range:NSMakeRange(range_curr.location,range_curr.length)];
        [str addAttribute:NSFontAttributeName value:Font_System_Bold(12) range:NSMakeRange(range_curr.location,range_curr.length)];
    }
    [btn setAttributedTitle:str forState:UIControlStateNormal];
}

- (UIButton*)edBtn
{
    if (!_edBtn) {
        _edBtn = [UIButton new];
        _edBtn.titleLabel.numberOfLines = 0;
        _edBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _edBtn;
}

- (UIButton*)canBtn
{
    if (!_canBtn) {
        _canBtn = [UIButton new];
        _canBtn.titleLabel.numberOfLines = 0;
        _canBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _canBtn;
}

- (UIButton*)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton new];
        _confirmBtn.titleLabel.numberOfLines = 0;
        _confirmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _confirmBtn;
}

- (UIButton*)ingBtn
{
    if (!_ingBtn) {
        _ingBtn = [UIButton new];
        _ingBtn.titleLabel.numberOfLines = 0;
        _ingBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _ingBtn;
}

@end

@implementation MeHeadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        UILabel* nameLabel = [UILabel new];
//        nameLabel.textColor = hexColor(ffffff);
//        nameLabel.text = @"个人中心";
//        nameLabel.font = Font_System_Bold(14);
//        [self.contentView addSubview:nameLabel];
//        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.offset(0);
//            make.top.offset(28);
//        }];
//        
//        [self.contentView addSubview:self.editBtn];
//        [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(nameLabel);
//            make.right.offset(-12);
//            make.size.mas_equalTo(CGSizeMake(24, 24));
//        }];
        
        [self.contentView addSubview: self.photoView];
        [self.contentView addSubview: self.titleLabel];
        [self.contentView addSubview: self.infoLabel];
        self.photoView.backgroundColor = RandomColor;

        [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView).offset(0);
//            make.centerY.equalTo(self.contentView).offset(-15);
            make.top.offset(20);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/5, SCREEN_WIDTH/7));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.photoView.mas_bottom).offset(10);
            make.centerX.equalTo(self.contentView);
        }];
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(6);
            make.centerX.equalTo(self.contentView);
        }];
    }
    return self;
}

//- (UIButton*)editBtn
//{
//    if (!_editBtn) {
//        _editBtn = [UIButton new];
//        [_editBtn setImage:ImageNamed(@"tab_icon_wo") forState:UIControlStateNormal];
//    }
//    return _editBtn;
//}

- (UIImageView *)photoView
{
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.image = [UIImage imageNamed:@"chuqin_con_tong"];
    }
    return _photoView;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"33";
        _titleLabel.textColor = hexColor(ffffff);
        _titleLabel.font = Font_System_Bold(14);
    }
    return _titleLabel;
}

- (UILabel*)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [UILabel new];
        _infoLabel.text = @"33";
        _infoLabel.textColor = hexColor(ffffff);
        _infoLabel.font = Font_System(12);
    }
    return _infoLabel;
}

@end
