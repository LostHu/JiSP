//
//  MeGameTableViewCell.h
//  GameBiBi
//
//  Created by Lost on 2017/8/9.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputViewTableViewCell.h"

@class MeInfoBtn;
@interface MeDefaultTableViewCell : InputViewTableViewCell
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* infoLabel;
@property (nonatomic, strong) UIImageView* iconView;
@property (nonatomic, strong) UIView* redView;
@property (nonatomic, strong) UIView* gapLineView;
@end

@interface MeColourfulTableViewCell : InputViewTableViewCell
@property (nonatomic, strong) MeInfoBtn* carBtn;
@property (nonatomic, strong) MeInfoBtn* userBtn;
@property (nonatomic, strong) MeInfoBtn* driverBtn;
@property (nonatomic, strong) MeInfoBtn* callBtn;
@property (nonatomic, strong) MeInfoBtn* freeBtn;
@property (nonatomic, strong) MeInfoBtn* callManagerBtn;
@property (nonatomic, strong) MeInfoBtn* leaveBtn;
@property (nonatomic, strong) MeInfoBtn* editPwdBtn;
@property (nonatomic, strong) NSArray* arrayTitle;

@property (nonatomic, copy) void (^selectIndex)(NSInteger index);
@end

@interface MeInfoBtn : UIButton
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* infoLabel;
@property (nonatomic, strong) UIImageView* iconView;
@end
