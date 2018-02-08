//
//  DriverData.h
//  JiSuPai
//
//  Created by Lost on 2018/1/28.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DriverData : NSObject
@property (nonatomic, assign) NSInteger driverId;

@property (nonatomic, assign) NSInteger cartype;
@property (nonatomic, strong) NSString* cartypeInCn;
@property (nonatomic, strong) NSString* carno;
@property (nonatomic, strong) NSString* sfzno;
@property (nonatomic, strong) NSString* jzno;
@property (nonatomic, strong) NSString* region;
@property (nonatomic, assign) NSInteger yunlimgrid;
@property (nonatomic, strong) NSString* yunlimgrname;
@property (nonatomic, strong) NSString* yunlimgrtel;
@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* loginname;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, assign) NSInteger usertype;
@property (nonatomic, strong) NSString* device;
@property (nonatomic, strong) NSString* appversion;
@property (nonatomic, strong) NSString* createtime;
@property (nonatomic, strong) NSString* lastlogin;

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString* statusInCn;

@property (nonatomic, assign) CGFloat lastgeox;
@property (nonatomic, assign) CGFloat lastgeoy;


@end
