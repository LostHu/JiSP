//
//  FreeTimeViewModel.h
//  JiSuPai
//
//  Created by Lost on 2018/1/21.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "BaseViewModel.h"
#import "FreeTimeData.h"

@interface FreeTimeViewModel : BaseTableViewModel
@property (nonatomic, strong) NSArray* arrayHour;
@property (nonatomic, strong) NSArray* arrayMin;
@end
