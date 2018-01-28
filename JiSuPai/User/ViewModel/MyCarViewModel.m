//
//  MyCarViewModel.m
//  JiSuPai
//
//  Created by Lost on 2018/1/28.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "MyCarViewModel.h"

@implementation MyCarViewModel

- (id)init
{
    self = [super init];
    if (self) {
        _arrayCarType = [NSMutableArray new];
        _arrayRegion = @[@"黄浦",@"徐汇",@"长宁",@"静安",@"普陀",@"虹口",@"杨浦",@"闵行",@"宝山",@"嘉定",@"浦东",@"金山",@"松江",@"青浦",@"奉贤",@"崇明"];
    }
    return self;
}

- (void)postDirverData:(ModelCompleteBlock)block
{
    
}

- (void)getDriverInfo:(ModelCompleteBlock)block
{
    NSMutableDictionary* parameters = [NSMutableDictionary new];
    [LostHttpClient GETRequestURL:API_GetDriverInfo WithParameter:parameters WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
        if (returnValue) {
            self.driverData_Copy = [DriverData modelWithDictionary:returnValue];
            self.driverData = self.driverData_Copy;
        }else{
            [HUD showMsg:appendData.msg type: HUDMsgType_Error];
        }
        if (block) {
            block(nil,YES);
        }
    } WithFailureBlock:^{
        
    }];
}

- (void)getCarTypeList:(ModelCompleteBlock)block
{
    NSMutableDictionary* parameters = [NSMutableDictionary new];
    [LostHttpClient GETRequestURL:API_GetCarTypeList WithParameter:parameters WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
        if (returnValue && [returnValue isKindOfClass:[NSDictionary class]]) {
            NSDictionary* dic = returnValue;
            NSMutableArray* tempArray = [NSMutableArray new];
            [dic enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
                
                NSLog(@"%@ %@",key, obj);
                
                NSDictionary* newData = @{key:obj};
                [tempArray addObject:newData];
                
            }];
            self.arrayCarType = tempArray;
            if (block) {
                block(nil,YES);
            }
        }else{
            [HUD showMsg:appendData.msg type: HUDMsgType_Error];
        }
        if (block) {
            block(nil,YES);
        }
    } WithFailureBlock:^{
        
    }];
}

@end
