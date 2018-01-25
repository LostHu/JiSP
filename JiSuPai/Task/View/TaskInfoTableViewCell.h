//
//  TaskInfoTableViewCell.h
//  JiSuPai
//
//  Created by Lost on 2018/1/14.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskInfoBaseTableViewCell : UITableViewCell
@property (nonatomic,strong) UIView* bgView;
@property (nonatomic,strong) UILabel* titleLabel;
@property (nonatomic,strong) UILabel* indexLabel;
@property (nonatomic,strong) UIView* lineView;
@property (nonatomic, strong) TaskData* data;
@end

@interface TaskInfoAddPhotoTableViewCell : TaskInfoBaseTableViewCell
@property (nonatomic,strong) UIButton* addBtn;
@end

@interface TaskInfoBasicTableViewCell : TaskInfoBaseTableViewCell
@end

@interface TaskInfoTableViewCell : TaskInfoBaseTableViewCell

@end

@interface TaskInfoCargoTableViewCell : TaskInfoBaseTableViewCell

@end

@interface TaskInfoAdditionalTableViewCell : TaskInfoBaseTableViewCell
@property (nonatomic,strong) UILabel* contentLabel;
@end
