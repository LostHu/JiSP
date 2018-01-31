//
//  MyCarViewModel.h
//  JiSuPai
//
//  Created by Lost on 2018/1/28.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "BaseViewModel.h"
#import "DriverData.h"

@interface MyCarViewModel : BaseViewModel
@property (nonatomic, strong) DriverData* driverData;
@property (nonatomic, strong) DriverData* driverData_Copy;// 用于备份数据，比较

@property (nonatomic, strong) NSArray* arrayTitle;
@property (nonatomic, strong) NSArray* arrayRegion;
@property (nonatomic, strong) NSMutableArray* arrayCarType;
- (void)postDirverData:(ModelCompleteBlock)block;
- (void)getDriverInfo:(ModelCompleteBlock)block;
- (void)getCarTypeList:(ModelCompleteBlock)block;
- (void)postDriverPhoto:(UIImage*)img tag:(NSInteger)tag block:(ModelCompleteBlock)block;
@end
