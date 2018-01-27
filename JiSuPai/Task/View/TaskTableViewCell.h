//
//  TaskTableViewCell.h
//  JiSuPai
//
//  Created by Lost on 2018/1/13.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskData.h"

@interface TaskTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel* titleLabel;
@property (nonatomic,strong) UIButton* phoneBtn;
@property (nonatomic,strong) YYLabel* stateLabel;

@property (nonatomic,strong) UILabel* startLabel;
@property (nonatomic,strong) UILabel* areaLabel;
@property (nonatomic,strong) UILabel* dateLabel;
@property (nonatomic,strong) UILabel* timeLabel;

@property (nonatomic, strong) UIButton* stateBtn;

@property (nonatomic,strong) UIButton* infoBtn;
@property (nonatomic,strong) UIButton* okBtn;

@property (nonatomic, strong) TaskData* data;
@end
