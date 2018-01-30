//
//  LeaveViewModel.h
//  JiSuPai
//
//  Created by Lost on 2018/1/26.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "BaseViewModel.h"
#import "LeaveData.h"

@interface LeaveViewModel : BaseTableViewModel
@property (nonatomic, strong) NSDate* startDate;
@property (nonatomic, strong) NSDate* endDate;
@property (nonatomic, strong) NSString* descrip;
- (void)addLeave:(ModelCompleteBlock)block;
- (void)delLeave:(LeaveData*)data block:(ModelCompleteBlock)block;
@end
