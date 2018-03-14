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
        self.locationManager.distanceFilter = 500;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
        [self.locationManager setPausesLocationUpdatesAutomatically:NO];
        
        //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
            self.locationManager.allowsBackgroundLocationUpdates = YES;
        }
        
        self.timer = [[LostCountDownTimer alloc] init];
        
        @weakify(self);
        [self.timer startTimerWithBlock:^{
            @strongify(self);
            NSLog(@"----------Timer postLocation-------------");
//            [self postLocation];
        }];
    }
    return self;
}

- (void)postLocation
{
    if (!CLLocationCoordinate2DIsValid(self.location)) {
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
                     NSLog(@"----------postLocation Success-------------");
                 }
                 else
                 {
                 }
             }
                 WithFailureBlock:^{
                     
                 }];
}

- (void)changeCountDown
{
//    __block int timeout = 59; //倒计时时间
//    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
//    
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0,queue);
//    
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0),1.0*NSEC_PER_SEC,0); //每秒执行
//    
//    dispatch_source_set_event_handler(_timer, ^{
//        
//        if(timeout<=0){//倒计时结束，关闭
//            
//            dispatch_source_cancel(_timer);
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                //设置界面的按钮显示根据自己需求设置
//                
//                [self.signUpButton setTitle:@"发送验证码"forState:UIControlStateNormal];
//                
//                self.signUpButton.enabled = YES;//设置button可点击
//                
//            });
//            
//        }else{
//            
//            //int minutes = timeout / 60;
//            
//            int seconds = timeout % 60;
//            
//            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                //设置界面的按钮显示根据自己需求设置
//                
//                NSLog(@"____%@",strTime);
//                
//                [self.signUpButton setTitle:[NSString stringWithFormat:@"剩余%@秒",strTime]forState:UIControlStateNormal];
//                
//                self.signUpButton.enabled = NO;//设置button不可点击
//                
//                //do what you are want
//                
//                
//                
//                
//                
//            });
//            
//            timeout--;
//            
//            
//            
//        }
//        
//    });
//    
//    dispatch_resume(_timer);
}

- (void)startLoaction
{
    [self.locationManager startUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    self.location = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
}

@end
