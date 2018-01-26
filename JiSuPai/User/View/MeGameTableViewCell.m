//
//  MeGameTableViewCell.m
//  GameBiBi
//
//  Created by Lost on 2017/8/9.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import "MeGameTableViewCell.h"

#define TagImage 89765

@interface MeDefaultTableViewCell()

@end

@implementation MeDefaultTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wo_btn_you_gray"]];
        self.accessoryView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.iconView];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(12);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        _iconView.layer.cornerRadius = 12.5;

        
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.text = @"我的游戏";
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.iconView.mas_right).offset(15);
        }];
        
        
        [self.contentView addSubview:self.infoLabel];
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-11.75);
            make.left.equalTo(self.contentView).offset(SCREEN_WIDTH/3);
        }];
        
        [self.contentView addSubview:self.redView];
        [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(5, 5));
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.titleLabel.mas_right).offset(1);
        }];
        
        [self.contentView addSubview:self.gapLineView];
        [self.gapLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@(0.5));
            make.bottom.right.equalTo(self);
            make.left.equalTo(self.contentView).offset(40);
        }];
    }
    return self;
}

- (void)dealloc
{
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = rgbfromHex(@"151515");
        _titleLabel.font = Font_System(12);
    }
    return _titleLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.backgroundColor = [UIColor whiteColor];
        _infoLabel.textColor = rgbfromHex(@"a3a3a3");
        _infoLabel.font = Font_System(15);
        _infoLabel.textAlignment = NSTextAlignmentRight;
        _infoLabel.clipsToBounds = YES;
    }
    return _infoLabel;
}

- (UIView *)gapLineView
{
    if (!_gapLineView) {
        _gapLineView = [[UIView alloc] init];
        _gapLineView.backgroundColor = rgbfromHex(@"ebf0f2");
        _gapLineView.hidden = YES;
    }
    return _gapLineView;
}

- (UIView *)redView
{
    if (!_redView) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = rgbfromHex(@"ff0000");
        _redView.clipsToBounds = YES;
        _redView.layer.cornerRadius = 2.5;
        _redView.hidden = YES;
    }
    return _redView;
}

- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"tab_icon_faxian_pre"];
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}

@end

#define MeColourTag 8700
@implementation MeColourfulTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.carBtn.tag = MeColourTag;
        self.userBtn.tag = MeColourTag+1;
        self.driverBtn.tag = MeColourTag+2;
        self.callBtn.tag = MeColourTag+3;
        self.freeBtn.tag = MeColourTag+4;
        self.callManagerBtn.tag = MeColourTag+5;
        self.leaveBtn.tag = MeColourTag+6;
        self.editPwdBtn.tag = MeColourTag+7;
        
        [self.carBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.userBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.driverBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.callBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.freeBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.callManagerBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.leaveBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.editPwdBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.carBtn];
        [self.carBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.offset(10);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH-30)/2, 45));
        }];
        
        [self.contentView addSubview:self.driverBtn];
        [self.driverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.left.equalTo(self.carBtn);
            make.top.equalTo(self.carBtn.mas_bottom).offset(0);
        }];
        
        [self.contentView addSubview:self.freeBtn];
        [self.freeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.driverBtn.mas_bottom).offset(0);
            make.size.left.equalTo(self.carBtn);
        }];
        
        [self.contentView addSubview:self.leaveBtn];
        [self.leaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.freeBtn.mas_bottom).offset(0);
            make.size.left.equalTo(self.carBtn);
        }];
        
        [self.contentView addSubview:self.userBtn];
        [self.userBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.top.equalTo(self.carBtn);
            make.left.equalTo(self.carBtn.mas_right);
        }];
        
        [self.contentView addSubview:self.callBtn];
        [self.callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userBtn.mas_bottom).offset(0);
            make.size.left.equalTo(self.userBtn);
        }];
        
        [self.contentView addSubview:self.callManagerBtn];
        [self.callManagerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.callBtn.mas_bottom).offset(0);
            make.size.left.equalTo(self.userBtn);
        }];
                
        [self.contentView addSubview:self.editPwdBtn];
        [self.editPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.callManagerBtn.mas_bottom).offset(0);
            make.size.left.equalTo(self.userBtn);
        }];
    }
    return self;
}

- (void)click:(MeInfoBtn*)btn
{
    if (btn && self.selectIndex) {
        self.selectIndex(btn.tag - MeColourTag);
    }
}

- (void)setArrayTitle:(NSArray *)arrayTitle
{
    if (!arrayTitle) {
        return;
    }
    _arrayTitle = arrayTitle;
    
    for (int i = 0; i<_arrayTitle.count; i++) {
        YZTabItemData* item = [_arrayTitle objectAtIndex:i];
        MeInfoBtn* btn = [self.contentView viewWithTag:MeColourTag+i];
        btn.nameLabel.text = item.title;
        btn.infoLabel.text = item.info;
        btn.iconView.image = ImageNamed(item.imgNormal);
    }
}

- (void)dealloc
{
    
}

- (MeInfoBtn *)callBtn
{
    if (!_callBtn) {
        _callBtn = [[MeInfoBtn alloc] init];
    }
    return _callBtn;
}

- (MeInfoBtn *)editPwdBtn
{
    if (!_editPwdBtn) {
        _editPwdBtn = [[MeInfoBtn alloc] init];
    }
    return _editPwdBtn;
}

- (MeInfoBtn *)leaveBtn
{
    if (!_leaveBtn) {
        _leaveBtn = [[MeInfoBtn alloc] init];
    }
    return _leaveBtn;
}

- (MeInfoBtn *)callManagerBtn
{
    if (!_callManagerBtn) {
        _callManagerBtn = [[MeInfoBtn alloc] init];
    }
    return _callManagerBtn;
}

- (MeInfoBtn *)driverBtn
{
    if (!_driverBtn) {
        _driverBtn = [[MeInfoBtn alloc] init];
    }
    return _driverBtn;
}

- (MeInfoBtn *)userBtn
{
    if (!_userBtn) {
        _userBtn = [[MeInfoBtn alloc] init];
    }
    return _userBtn;
}

- (MeInfoBtn *)freeBtn
{
    if (!_freeBtn) {
        _freeBtn = [[MeInfoBtn alloc] init];
    }
    return _freeBtn;
}

- (MeInfoBtn *)carBtn
{
    if (!_carBtn) {
        _carBtn = [[MeInfoBtn alloc] init];
    }
    return _carBtn;
}

@end

@implementation MeInfoBtn


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubview:self.iconView];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(1);
            make.left.offset(1);
            make.size.mas_equalTo(CGSizeMake(12, 12));
        }];
        
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconView);
            make.left.equalTo(self.iconView.mas_right).offset(5);
        }];
        
        [self addSubview:self.infoLabel];
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(4);
            make.left.equalTo(self.nameLabel);
        }];
    }
    return self;
}

- (void)dealloc
{
    
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor whiteColor];
        _nameLabel.textColor = rgbfromHex(@"151515");
        _nameLabel.font = Font_System(12);
    }
    return _nameLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.backgroundColor = [UIColor whiteColor];
        _infoLabel.textColor = rgbfromHex(@"a3a3a3");
        _infoLabel.font = Font_System(11);
        _infoLabel.textAlignment = NSTextAlignmentRight;
        _infoLabel.clipsToBounds = YES;
    }
    return _infoLabel;
}

- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"tab_icon_faxian_pre"];
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}

@end

