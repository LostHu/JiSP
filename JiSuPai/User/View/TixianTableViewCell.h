//
//  TixianTableViewCell.h
//  JiSuPai
//
//  Created by Lost on 2018/2/8.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiXianTableViewModel.h"

@interface TixianTableViewCell : UITableViewCell
@property (nonatomic, strong) TixianData* data;
@property (nonatomic, strong) UILabel* dateLabel;
@property (nonatomic, strong) UILabel* sqjeLabel;
@property (nonatomic, strong) UILabel* tixianLabel;
@property (nonatomic, strong) UILabel* descLabel;
@property (nonatomic, strong) UIButton* stateBtn;
@property (nonatomic, strong) UIView* bgView;
@end
