//
//  TiXianTableViewModel.h
//  JiSuPai
//
//  Created by Lost on 2018/2/8.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "BaseViewModel.h"

@interface TixianData : NSObject
@property (nonatomic, assign) double createtime;
@property (nonatomic, assign) CGFloat shenqingjine;
@property (nonatomic, assign) CGFloat tixianjine;
@property (nonatomic, strong) NSString* statusInCn;
@property (nonatomic, strong) NSString* descrip;
@end

@interface TiXianTableViewModel : BaseTableViewModel

@end
