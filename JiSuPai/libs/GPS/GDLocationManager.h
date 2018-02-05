//
//  GDLocationManager.h
//  JiSuPai
//
//  Created by Lost on 2018/2/5.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#define GDMAP_KEY @"b00bb1876c649736dd9183b721264132"

@interface GDLocationManager : NSObject<AMapLocationManagerDelegate>
DEFINE_SINGLETON_FOR_HEADER(GDLocationManager);
@property (nonatomic, strong) AMapLocationManager* locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D location;
- (void)startLoaction;
- (void)postLocation;
@end
