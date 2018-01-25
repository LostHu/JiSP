//
//  MeViewModel.h
//  JiSuPai
//
//  Created by Lost on 2018/1/15.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "BaseViewModel.h"

@interface MeViewModel : BaseViewModel
@property (nonatomic, strong) UserData* userData;
@property (nonatomic, strong) NSMutableArray<YZTabItemData*>* arrayTabData;
@end
