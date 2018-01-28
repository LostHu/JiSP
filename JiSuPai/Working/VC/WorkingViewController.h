//
//  WorkingViewController.h
//  JiSuPai
//
//  Created by Lost on 2018/1/28.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TaskInfoViewController.h"
#import "WorkingViewModel.h"

@interface WorkingViewController : BaseTableViewController
@property (nonatomic, strong) NSArray* arrayTitle ;
@property (nonatomic,strong) WorkingViewModel* viewModel;
@end
