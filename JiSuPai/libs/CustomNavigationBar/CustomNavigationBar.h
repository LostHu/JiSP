//
//  CustomNavigationBar.h
//  CaiLianShe
//
//  Created by chenny on 15/6/1.
//  Copyright (c) 2015年 chenny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationBar : UIView

@property (nonatomic, retain) UIButton *rightButton;
@property (nonatomic, retain) UIButton *leftButton;
@property (nonatomic, retain) UIView *bottomLine;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIView *bgView;
@property (nonatomic, retain) UIView *contentView;

- (id)init;
- (void)transparent;

@end
