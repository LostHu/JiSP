//
//  MeViewModel.m
//  JiSuPai
//
//  Created by Lost on 2018/1/15.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "MeViewModel.h"

@implementation MeViewModel
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSArray* arrayTitle = @[@"车辆信息",@"客户评价",@"司机学院",@"联系我们",@"空闲时间",@"修改密码"];
        NSArray* arrayInfo = @[@"完善车辆信息",@"查看客户评价",@"查看司机学院",@"4008556505",@"查看空闲时间",@"点击修改密码"];
        NSArray *iocnNormalArray = @[@"tab_icon_dongtai",@"tab_icon_faxian",@"tab_icon_faxian",@"tab_icon_wo",@"tab_icon_faxian",@"tab_icon_wo"];
        NSArray *iconSeclectArray = @[@"tab_icon_dongtai_pre",@"tab_icon_faxian_pre",@"tab_icon_faxian_pre",@"tab_icon_wo_pre",@"tab_icon_faxian_pre",@"tab_icon_wo_pre"];
        
        _arrayTabData = [NSMutableArray new];
        for (int i = 0; i < arrayTitle.count; i++) {
            YZTabItemData* item = [YZTabItemData new];
            item.title = arrayTitle[i];
            item.info = arrayInfo[i];
            item.imgNormal = iocnNormalArray[i];
            item.imgSelect = iconSeclectArray[i];
            [_arrayTabData addObject:item];
        }
        
        @weakify(self);
        [RACObserve([UserManager sharedInstance], userData) subscribeNext:^(id x) {
            @strongify(self);
            if (x && [x isKindOfClass:[UserData class]]) {
                self.userData = (UserData*)x;
            }
        }];
    }
    return self;
}
@end
