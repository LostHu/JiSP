//
//  LeaveData.h
//  JiSuPai
//
//  Created by Lost on 2018/1/26.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeaveData : NSObject
@property (nonatomic, assign) NSInteger driverid;
@property (nonatomic, strong) NSString* startdate;
@property (nonatomic, strong) NSString* enddate;
@property (nonatomic, strong) NSString* descrip;
@property (nonatomic, strong) NSString* createtime;
@property (nonatomic, assign) NSInteger leaveId;

@end
