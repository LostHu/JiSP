//
//  TaskInfoViewModel.h
//  JiSuPai
//
//  Created by Lost on 2018/1/14.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "BaseViewModel.h"
#import "TaskData.h"

@interface TaskInfoViewModel : BaseViewModel
@property (nonatomic, strong) TaskData* data;
@property (nonatomic, strong) NSMutableArray* arrayPhotos;
- (void)getOrderPhoto:(ModelCompleteBlock)block;
- (void)postOrderPhoto:(UIImage*)img name:(NSString*)name block:(ModelCompleteBlock)block;

@end
