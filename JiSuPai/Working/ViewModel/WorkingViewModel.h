//
//  WorkingViewModel.h
//  JiSuPai
//
//  Created by Lost on 2018/1/28.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TaskInfoViewModel.h"

@interface WorkingViewModel : BaseViewModel

- (void)getWorkingData:(ModelCompleteBlock)block;
- (void)getWorkingExceptionData:(ModelCompleteBlock)block;
- (void)addWorkingExceptionType:(NSString*)type desc:(NSString*)desc block:(ModelCompleteBlock)block;

@property (nonatomic, strong) TaskData* data;
@property (nonatomic, strong) NSMutableArray* arrayException;
@property (nonatomic, strong) NSMutableArray* arrayPhotos;
- (void)getOrderPhoto:(ModelCompleteBlock)block;

@end
