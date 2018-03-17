//
//  LostHttpClient.m
//  Football
//
//  Created by lost on 15/7/15.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "LostHttpClient.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>
// 运营商信息
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation LostHttpClient

DEFINE_SINGLETON_FOR_CLASS(LostHttpClient)

#pragma 监测网络的可链接性
- (void)startMonitoringNetWorkState
{
    @weakify(self);
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        @strongify(self);
        // 运营商信息
        CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
        NSString* mobileTypeValue = [[NSString alloc] initWithFormat:@"%@",info.currentRadioAccessTechnology];
        
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
            self.netReachableType = ReachableType_None;
        }
        else
        {
            if ([[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi]) {
                self.netReachableType = ReachableType_WIFI;
            }
            else
            {
                if ([mobileTypeValue isEqualToString:CTRadioAccessTechnologyLTE]) {
                    self.netReachableType = ReachableType_4G;
                }
                else if ([mobileTypeValue isEqualToString:CTRadioAccessTechnologyGPRS] ||
                         [mobileTypeValue isEqualToString:CTRadioAccessTechnologyEdge]) {
                    self.netReachableType = ReachableType_2G;
                }
                else {
                    self.netReachableType = ReachableType_3G;
                }
            }
        }
    }];
    
    // 开始监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (void)postLocationForAction:(NSString*)url
{
    if (![[UserManager sharedInstance] hasAccount]) {
        return;
    }
    if (![NSString isBlankString:url]) {
        if ([url isEqualToString:API_sendLocation]) {
            return;
        }
    }
    
    [[GDLocationManager sharedInstance] postLocation];
}

+ (void)addTokenToParameter:(NSMutableDictionary*)parameter withUrl:(NSString*)url
{
    [parameter setObject:@"2" forKey:@"device"];
    if (![NSString isBlankString:url]) {
        if ([url isEqualToString:API_registerHuozhu] ||
            [url isEqualToString:API_login] ||
            [url isEqualToString:API_resetPassword_Reset] ||
            [url isEqualToString:API_sendPhoneCode_Reset] ||
            [url isEqualToString:API_sendPhoneCode] ) {
            return;
        }
    }
//    NSString* token = [UserManager sharedInstance].token;
//    if (parameter && ![NSString isBlankString:token]) {
//        [parameter setObject:token forKey:@"token"];
//    }
    
    NSString *phone = [UserManager sharedInstance].loginname;
    NSString *pwd = [UserManager sharedInstance].password;          // 所有接口添加平台参数  1、ios 2、android

    if (![NSString isBlankString:pwd]) {
        [parameter setObject:[pwd md5] forKey:@"password"];
    }
    if (![NSString isBlankString:phone]) {
        [parameter setObject:phone forKey:@"loginname"];
    }
    
//    [parameter setObject:@(1) forKey:@"version"];
}
#define DebugLog
#pragma --mark GET请求方式
+ (void) GETRequestURL: (NSString *) requestURLString
         WithParameter: (NSMutableDictionary *) parameter
  WithReturnValeuBlock: (ReturnValueBlock) block
      WithFailureBlock: (FailureBlock) failureBlock
{
    parameter = [NSMutableDictionary dictionaryWithDictionary:parameter];
    [self addTokenToParameter:parameter withUrl:requestURLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
//    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    // 未登录 && 非登录注册操作
    if (![[UserManager sharedInstance] hasAccount] && ![[UserManager sharedInstance] hasAuthforURL:requestURLString]) {
        if (block) {
            block(nil,nil);
        }
        return;
    }
    
//    //申明返回的结果是json类型
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    //申明请求的数据是json类型
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    //如果报接受类型不一致请替换一致text/html或别的
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString *requestUrl = [AppBaseUrl stringByAppendingString:requestURLString];
#ifdef DebugLog
    DDLog(@"%@",requestUrl);
    DDLog(@"%@",parameter);
#endif
    @weakify(self)
    [manager GET:requestUrl parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DDLog(@"%@", responseObject);
        @strongify(self)
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            HttpResponseData* appendData = [[HttpResponseData alloc] initWithDictionary:responseObject];
            
            // 操作成功后发送坐标系
            if (appendData.flag == YES) {
                [self postLocationForAction:requestURLString];
            }
            
            if (block) {
                block(responseObject,appendData);
            }
            [self checkResultError:appendData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DDLog(@"%@", [error description]);
        failureBlock();
        [HUD showMsg:@"网络异常" type:HUDMsgType_Error];
    }];
}

#pragma --mark POST请求方式
+ (void) POSTRequestURL: (NSString *) requestURLString
          WithParameter: (NSMutableDictionary *) parameter
   WithReturnValeuBlock: (ReturnValueBlock) block
       WithFailureBlock: (FailureBlock) failureBlock
{
    parameter = [NSMutableDictionary dictionaryWithDictionary:parameter];
    [self addTokenToParameter:parameter withUrl:requestURLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager setValue:@"application/json" forKey:@"Content-Type"];
    
    if (![[UserManager sharedInstance] hasAccount] && ![[UserManager sharedInstance] hasAuthforURL:requestURLString]) {
        if (block) {
            block(nil,nil);
        }
        return;
    }
    
    NSString *requestUrl = [AppBaseUrl stringByAppendingString:requestURLString];
#ifdef DebugLog
    DDLog(@"%@",requestUrl);
    DDLog(@"%@",parameter);
#endif
    
    @weakify(self)
    [manager POST:requestUrl parameters:parameter constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        #ifdef DebugLog
            DDLog(@"%@", responseObject);
        #endif
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            HttpResponseData* appendData = [[HttpResponseData alloc] initWithDictionary:responseObject];
            if (block) {
                block(responseObject,appendData);
            }
            [self checkResultError:appendData];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 网络错误
        DDLog(@"%@", [error description]);
        failureBlock();
        [HUD showMsg:@"网络异常" type:HUDMsgType_Error];
    }];
}

+ (void) POSTFileURL: (NSString *) requestURLString
           parameter: (NSMutableDictionary *) parameter
            fileList: (NSArray*) arrayFile
            fileType: (PostSourceType) type
        successBlock: (ReturnValueBlock) block
       progressBlock: (ProgressBlock) progressBlock
        failureBlock: (FailureBlock) failureBlock
{

    [self POSTFileURL:requestURLString
            parameter:parameter
             fileList:arrayFile
             fileName:nil
             fileType:type
         successBlock:^(id returnValue, HttpResponseData *appendData) {
             if (block) {
                 block(returnValue,appendData);
             }
         }
        progressBlock: ^(CGFloat progress)
         {
             if (progressBlock) {
                 progressBlock(progress);
             }
         }
         failureBlock:^{
             failureBlock();
    }];
}


+ (void) POSTFileURL: (NSString *) requestURLString
           parameter: (NSMutableDictionary *) parameter
            fileList: (NSArray*) arrayFile
            fileName: (NSArray*) fileNameArray
        successBlock: (ReturnValueBlock) block
       progressBlock: (ProgressBlock) progressBlock
        failureBlock: (FailureBlock) failureBlock
{
    [self POSTFileURL:requestURLString
            parameter:parameter
             fileList:arrayFile
             fileName:fileNameArray
             fileType:PostSourceType_Photo
         successBlock:^(id returnValue, HttpResponseData *appendData) {
             if (block)
                 block(returnValue,appendData);
         }
        progressBlock: ^(CGFloat progress) {
             if (progressBlock) {
                 progressBlock(progress);
             }
         }
         failureBlock:^{
             failureBlock();
         }];
}

+ (void) POSTFileURL: (NSString *) requestURLString
           parameter: (NSMutableDictionary *) parameter
            fileList: (NSArray*) arrayFile
            fileName: (NSArray*) fileNameArray
            fileType: (PostSourceType) type
        successBlock: (ReturnValueBlock) block
       progressBlock: (ProgressBlock) progressBlock
        failureBlock: (FailureBlock) failureBlock

{
    parameter = [NSMutableDictionary dictionaryWithDictionary:parameter];
    [self addTokenToParameter:parameter withUrl:requestURLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    NSString *requestUrl = [AppBaseUrl stringByAppendingString:requestURLString];
    
    [manager POST:requestUrl parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (type == PostSourceType_Photo) {
            for (int i=0; i<arrayFile.count; i++)
            {
                UIImage* image = [arrayFile objectAtIndex:i];
                NSData* data = UIImagePNGRepresentation(image);
                
                NSString* name;
                if (fileNameArray.count >i) {
                    name = fileNameArray[i];
                }else{
                    name = [NSString stringWithFormat:@"%ld.png",(long)i];
                }
                
                [formData appendPartWithFileData:data name:name fileName:name mimeType:@"image/png"];
            }
        }
        
        if (type == PostSourceType_Video) {
            // 视频
            NSData* data = [arrayFile firstObject];
            NSString* videoname = [NSString stringWithFormat:@"%ld.mp4",(long)0];
            [formData appendPartWithFileData:data name:@"video" fileName:videoname mimeType:@"video/mp4"];
            
            if (arrayFile.count > 0) {
                // 视频截图
                NSString* imgname = [NSString stringWithFormat:@"%ld.png",(long)1];
                [formData appendPartWithFileData:[arrayFile lastObject] name:imgname fileName:imgname mimeType:@"image/png"];
            }
        }
        
        if (type == PostSourceType_Audio) {
            for (int i=0; i<arrayFile.count; i++) {
                NSData* data = [arrayFile objectAtIndex:i];
                NSString* name = [NSString stringWithFormat:@"%ld.m4a",(long)i];
                [formData appendPartWithFileData:data name:@"audio" fileName:name mimeType:@"audio/M4A"];
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DDLog(@"%.1fk Upload at %f", uploadProgress.totalUnitCount/1024.0, uploadProgress.fractionCompleted);
        
        if (progressBlock) {
            progressBlock(uploadProgress.fractionCompleted);
        };
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DDLog(@"%@", responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            HttpResponseData* appendData = [[HttpResponseData alloc] initWithDictionary:responseObject];
            
            // 操作成功后发送坐标系
            if (appendData.flag == YES) {
                [self postLocationForAction:requestURLString];
            }
            
            if (block) {
                block(responseObject,appendData);
            }
            [self checkResultError:appendData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 网络错误
        DDLog(@"%@", [error description]);
        failureBlock();
        [HUD showMsg:@"网络异常" type:HUDMsgType_Error];
    }];
}


// 检查是否有错误，如果有通常错误，直接基类处理
+ (void)checkResultError:(HttpResponseData*)data
{
    //返回成功
    if (data.code == 200) {
        NSString* msg = data.msg;
        if (![NSString isBlankString:msg])
        {
            [HUD showMsg: msg];
        }
        return;
    }
    
    
    if (data && !data.flag && data.code != 200) {
        NSString* msg = data.msg;
        switch (data.code) {
            case 10001:// 数据为空忽略
                break;
            case 2000:// token失效，网络层管理
                msg = nil;
                [[UserManager sharedInstance] clearUserData];
                [[NSNotificationCenter defaultCenter] postNotificationName: Notify_NeedLogin
                                                                    object:self
                                                                  userInfo:@{@"AppSystemEventType":@(ShowLogin),
                                                                             @"SuccessStatue":@(YES)}];
                break;
            case 3000:
                msg = nil;
                break;
            default:
                break;
        }
        if (![NSString isBlankString:msg]) {
            [HUD showMsg:msg type:HUDMsgType_Error];
        }
    }
}
@end
