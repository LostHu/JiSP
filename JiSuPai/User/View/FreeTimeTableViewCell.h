//
//  FreeTimeTableViewCell.h
//  JiSuPai
//
//  Created by Lost on 2018/1/21.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeTimeTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel* dateLabel;
@property (nonatomic, strong) UILabel* timeLabel;
@property (nonatomic, strong) UIButton* delBtn;
@property (nonatomic, strong) UIView* bgView;
@end
