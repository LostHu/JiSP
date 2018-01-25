//
//  HistoryTableViewCell.h
//  JiSuPai
//
//  Created by Lost on 2018/1/19.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UILabel* codeLabel;
@property (nonatomic, strong) TaskData* data;
@end

@interface HistorySubTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) TaskData* data;
@end
