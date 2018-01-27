//
//  WorkingViewModel.h
//  JiSuPai
//
//  Created by Lost on 2018/1/28.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TaskInfoViewModel.h"

@interface WorkingViewModel : TaskInfoViewModel
- (void)getWorkingData:(ModelCompleteBlock)block;

@end
