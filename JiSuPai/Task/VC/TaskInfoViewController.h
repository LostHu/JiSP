//
//  TaskInfoViewController.h
//  JiSuPai
//
//  Created by Lost on 2018/1/14.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "BaseViewController.h"
#import "TaskInfoTableViewCell.h"
#import "TaskInfoViewModel.h"

@interface TaskInfoViewController : BaseTableViewController
@property (nonatomic, strong) NSArray* arrayTitle ;
@property (nonatomic,strong) TaskInfoViewModel* viewModel;
@end
