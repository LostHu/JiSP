//
//  TaskData.h
//  JiSuPai
//
//  Created by Lost on 2018/1/16.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskData : NSObject
@property (nonatomic, strong) NSString* pureid;

@property (nonatomic, strong) NSString* taskid;
@property (nonatomic, strong) NSString* firstorderid;
@property (nonatomic, strong) NSString* userid;
@property (nonatomic, strong) NSString* driverid;
@property (nonatomic, assign) NSInteger tixianid;
@property (nonatomic, assign) NSInteger orderstatus;
@property (nonatomic, strong) NSString* orderstatusInCn;
@property (nonatomic, assign) NSInteger cartype;
@property (nonatomic, strong) NSString* cartypeInCn;

@property (nonatomic, strong) NSString* fahuoren;
@property (nonatomic, strong) NSString* fahuophone;
@property (nonatomic, strong) NSString* fahuoaddress;
@property (nonatomic, strong) NSString* descrip;
@property (nonatomic, assign) NSInteger isdelete;
@property (nonatomic, strong) NSString* createtime;
@property (nonatomic, strong) NSString* orderno;
@property (nonatomic, assign) NSInteger timetype;
@property (nonatomic, strong) NSString* timetypeInCn;
@property (nonatomic, strong) NSString* orderdate;
@property (nonatomic, strong) NSString* startdate;
@property (nonatomic, strong) NSString* enddate;
@property (nonatomic, strong) NSString* daogangtime;
@property (nonatomic, strong) NSString* costhour;
@property (nonatomic, strong) NSString* customername;
@property (nonatomic, strong) NSString* driveryaoqiu;

@property (nonatomic, strong) NSString* xianlu;
@property (nonatomic, assign) NSInteger peisongtype;
@property (nonatomic, strong) NSString* peisongtypeInCn;
@property (nonatomic, strong) NSString* peisongquyu;
@property (nonatomic, strong) NSString* peisongnum;
@property (nonatomic, strong) NSString* huowutype;
@property (nonatomic, assign) NSInteger huowunum;
@property (nonatomic, assign) NSInteger piaonum;

@property (nonatomic, assign) NSInteger ton;
@property (nonatomic, assign) NSInteger ton2;
@property (nonatomic, strong) NSString* tonInCn;
@property (nonatomic, assign) NSInteger cube;
@property (nonatomic, assign) NSInteger cube2;
@property (nonatomic, strong) NSString* cubeInCn;
@property (nonatomic, assign) NSInteger banyun;
@property (nonatomic, assign) NSInteger shanglou;
@property (nonatomic, assign) NSInteger tuiche;
@property (nonatomic, assign) NSInteger huidan;
@property (nonatomic, assign) NSInteger fancang;
@property (nonatomic, assign) NSInteger fenjian;
@property (nonatomic, assign) NSInteger daishou;
//@property (nonatomic, assign) NSInteger piaonum;

@property (nonatomic, strong) NSString* banyunInCn;
@property (nonatomic, strong) NSString* shanglouInCn;
@property (nonatomic, strong) NSString* tuicheInCn;
@property (nonatomic, strong) NSString* huidanInCn;
@property (nonatomic, strong) NSString* fancangInCn;
@property (nonatomic, strong) NSString* fenjianInCn;
@property (nonatomic, strong) NSString* daishouInCn;
@property (nonatomic, strong) NSString* otherservice;
@property (nonatomic, assign) NSInteger jiesuanfs;
@property (nonatomic, strong) NSString* jiesuanfsInCn;

@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger priceperone;
@property (nonatomic, assign) NSInteger lastprice;
@property (nonatomic, assign) NSInteger weitixian;
@property (nonatomic, assign) NSInteger yitixian;
@property (nonatomic, strong) NSString* drivernum;
@end
