//
//  HistoryTaskInfoViewController.h
//  JiSuPai
//
//  Created by Lost on 2018/2/6.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "BaseViewController.h"
#import "TaskInfoTableViewCell.h"
#import "TaskInfoViewModel.h"

@interface HistoryTaskInfoViewController : BaseTableViewController
@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, strong) NSArray* arrayTitle ;
@property (nonatomic, strong) TaskInfoViewModel* viewModel;
@end
