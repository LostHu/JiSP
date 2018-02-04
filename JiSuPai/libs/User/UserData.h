//
//  UserData.h
//  Lust
//
//  Created by Lost on 16/4/12.
//  Copyright © 2016年 Lost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"

@interface UserData : NSObject<NSCoding,NSCopying>

@property (nonatomic, assign) NSInteger lastprice;

@property (nonatomic, assign) NSInteger weitixian;
@property (nonatomic, assign) NSInteger tixianzhong;
@property (nonatomic, assign) NSInteger yitixian;
@property (nonatomic, assign) NSInteger daiqueren;

@property (nonatomic, assign) NSInteger ordercount;
@property (nonatomic, assign) NSInteger days;

@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * telephone;
@property (nonatomic, assign) NSInteger  status;
@property (nonatomic, strong) NSString * statusInCn;
@property (nonatomic, strong) NSString * yunlimgrtel;
@property (nonatomic, strong) NSString * yunlimgrname;

//@property (nonatomic, strong) NSString * pwd;
           // 0:临时账号   1:手机账号       为1显示根据level显示用户勋章，type为3显示小编固定勋章
//@property (nonatomic, assign) NSInteger pCount;           // P豆

//- (BOOL)isBanAccount;

@end

