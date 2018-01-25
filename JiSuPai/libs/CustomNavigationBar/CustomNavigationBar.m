//
//  CustomNavigationBar.m
//  CaiLianShe
//
//  Created by chenny on 15/6/1.
//  Copyright (c) 2015年 chenny. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar

- (id) init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight);
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.bgView];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.contentView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.bottomLine];
        
        [self initViewConstraints]; 
    }
    return self;
}

- (void)dealloc
{
    [_bgView removeFromSuperview];
    [_contentView removeFromSuperview];
    [_leftButton removeFromSuperview];
    [_rightButton removeFromSuperview];
    [_titleLabel removeFromSuperview];
    [_bottomLine removeFromSuperview];
    _bgView = nil;
    _leftButton = nil;
    _rightButton = nil;
    _titleLabel = nil;
    _bottomLine = nil;
    _contentView = nil;
}

- (void)initViewConstraints {
    WS(weakSelf);
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left);
        make.top.mas_equalTo(weakSelf.mas_top).offset(StatusBarHeight);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right).offset(-10);
        make.top.mas_equalTo(weakSelf.mas_top).offset(StatusBarHeight);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf).insets(UIEdgeInsetsMake(StatusBarHeight, 60, 0, 60));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf).insets(UIEdgeInsetsMake(StatusBarHeight, 60, 0, 60));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(@1);
    }];
}

#pragma mark - getters and setters

-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

-(UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _rightButton;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = NavigationBarDownLineColor;
    }
    return _bottomLine;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = NavigationBarTitleColor;
        _titleLabel.font = Font_System_Bold(18);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)transparent
{
//    self.alpha = 0;
    self.bgView.alpha = 0;
    [self.bottomLine setHidden:YES];
}

@end
