//
//  GDLocationManager.m
//  JiSuPai
//
//  Created by Lost on 2018/2/5.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "GDLocationManager.h"

@implementation GDLocationManager
DEFINE_SINGLETON_FOR_CLASS(GDLocationManager)

- (id)init
{
    self = [super init];
    if (self) {
        [AMapServices sharedServices].apiKey = GDMAP_KEY;
        self.locationManager = [[AMapLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = 100;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
        //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
        [self.locationManager setPausesLocationUpdatesAutomatically:NO];
        
        //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
            self.locationManager.allowsBackgroundLocationUpdates = YES;
        }
    }
    return self;
}

- (void)postLocation
{
    if (CLLocationCoordinate2DIsValid(self.location)) {
        return;
    }
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(self.location.latitude) forKey:@"geoy"];
    [parameters setObject:@(self.location.longitude) forKey:@"geox"];
    
    @weakify(self);
    [LostHttpClient GETRequestURL:API_sendLocation WithParameter:parameters
             WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
                 @strongify(self);
                 if (appendData.flag == YES) {
                     
                 }
                 else
                 {
//                     [HUD showMsg:appendData.msg type: HUDMsgType_Error];
                 }
             }
                 WithFailureBlock:^{
                     
                 }];
}

- (void)startLoaction
{
    [self.locationManager startUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    self.location = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
//    self.location.latitude = location.coordinate.latitude;
//    self.location.longitude = location.coordinate.longitude;
}

@end
