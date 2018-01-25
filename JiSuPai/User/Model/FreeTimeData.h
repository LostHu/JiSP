//
//  FreeTimeData.h
//  JiSuPai
//
//  Created by Lost on 2018/1/21.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FreeTimeData : NSObject
@property (nonatomic, assign) NSInteger driverid;
@property (nonatomic, strong) NSString* startdate;
@property (nonatomic, strong) NSString* enddate;
@property (nonatomic, strong) NSString* starttime;
@property (nonatomic, strong) NSString* endtime;
@property (nonatomic, strong) NSString* createtime;
@property (nonatomic, assign) NSInteger starthour;
@property (nonatomic, assign) NSInteger endhour;
@property (nonatomic, assign) NSInteger startminute;
@property (nonatomic, assign) NSInteger endminute;

@end
