//
//  ListDataVM.h
//  GTarcade
//
//  Created by VisonCui on 2017/12/28.
//  Copyright © 2017年 VisonCui. All rights reserved.
//

#import "BaseViewModel.h"

typedef void (^ModelCompleteBlock)(id data,BOOL isTodo);

@interface ListDataVM : NSObject

typedef void (^ParseItemBlock)(id data,BOOL isTodo);

@property (nonatomic, strong) NSMutableArray* array;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) BOOL bLast;

@end
