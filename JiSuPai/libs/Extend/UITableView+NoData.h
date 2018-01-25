//
//  UITableView+NoData.h
//  GameBiBi
//
//  Created by Lost on 2017/12/26.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoDataView.h"

@interface UITableView (NoData)
@property (nonatomic, assign) BOOL firstReload;
@property (nonatomic, strong) NoDataView *placeholderView;
@property (nonatomic,   copy) void(^reloadBlock)(void);
@end
