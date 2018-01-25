//
//  FirstTableViewCell.h
//  JiSuPai
//
//  Created by Lost on 2018/1/17.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskData.h"

@interface FirstTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel* titleLabel;
@property (nonatomic,strong) UIButton* phoneBtn;
@property (nonatomic,strong) UILabel* stateLabel;

@property (nonatomic, strong) UILabel* codeLabel;
@property (nonatomic, strong) UILabel* priceLabel;

@property (nonatomic, strong) UILabel* needCarLabel;
@property (nonatomic,strong) UILabel* startLabel;
@property (nonatomic,strong) UILabel* areaLabel;
@property (nonatomic,strong) UILabel* dateLabel;
@property (nonatomic,strong) UILabel* timeLabel;
@property (nonatomic,strong) UILabel* timeEndLabel;

@property (nonatomic,strong) UIButton* infoBtn;
@property (nonatomic,strong) UIButton* okBtn;

@property (nonatomic, strong) TaskData* data;
@end
