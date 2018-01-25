//
//  BaseViewModel.h
//  Football
//
//  Created by 崔伟战 on 15/11/27.
//  Copyright © 2015年 lost. All rights reserved.
//

#import <Foundation/Foundation.h>

//@protocol ViewModelListDelegate
//@required
///***
// 当前列表请求的URL
// ***/
//- (NSString*)getListUrl;
///***
// 当前列表请求返回结果如何解析每个个体
// ***/
//- (id)parseItem:(NSDictionary*)dic;
//@end

// 数据加载状态，标识是否加载过数据; 未加载 加载中 已加载
typedef NS_ENUM(NSInteger, ViewModelDataLoadState)
{
    Loadnone        = 1,
    Loading         = 2,
    Loaded          = 3,
};

typedef void (^ModelCompleteBlock)(id data,BOOL isTodo);

@interface BaseViewModel : NSObject

// 数据加载状态，标识是否加载过数据; 未加载 加载中 已加载
@property (nonatomic,assign) ViewModelDataLoadState dataLoadState;
//@property (nonatomic,assign) NetReachableType networkStatus;

@end


@interface BaseTableViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray* array;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) BOOL bLast;

- (void)getFirstList:(ModelCompleteBlock)block;
- (void)getData:(ModelCompleteBlock)block;


@end
