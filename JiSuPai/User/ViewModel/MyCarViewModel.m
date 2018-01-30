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
        _arrayTitle = @[@"身份证信息",@"车辆正面照",@"车辆侧面照",@"行驶证和驾驶信息"];
    }
    return self;
}

- (void)postDirverData:(ModelCompleteBlock)block
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(self.driverData.cartype) forKey:@"cartype"];
    [parameters setObject:self.driverData.sfzno forKey:@"sfzno"];
    [parameters setObject:self.driverData.carno forKey:@"carno"];
    [parameters setObject:self.driverData.jzno forKey:@"jzno"];
    [parameters setObject:self.driverData.username forKey:@"username"];
    
    [LostHttpClient GETRequestURL:API_Edit_Account WithParameter:parameters
             WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
                 if (appendData.flag == YES) {
                     if (block) {
                         block(nil,YES);
                     }
                 }
                 else
                 {
                     [HUD showMsg:appendData.msg type: HUDMsgType_Error];
                 }
             }
                 WithFailureBlock:^{
                     
                 }];
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
