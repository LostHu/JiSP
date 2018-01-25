//
//  HistoryListViewModel.h
//  JiSuPai
//
//  Created by Lost on 2018/1/19.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "BaseViewModel.h"

@interface HistoryListViewModel : BaseTableViewModel

@end

@interface HistorySubListViewModel : BaseTableViewModel
@property (nonatomic, strong) TaskData* taskData;
@end
