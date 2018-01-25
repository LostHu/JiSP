//
//  LostHttpClient.h
//  Football
//
//  Created by lost on 15/7/15.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIProtocol.h"
#import "HttpTask.h"

// 网络可达类型
typedef NS_ENUM(NSInteger, NetReachableType)
{
    ReachableType_None  = 0,
    ReachableType_2G    = 1,
    ReachableType_3G    = 2,
    ReachableType_4G    = 3,
    ReachableType_WIFI  = 100,
};

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue, HttpResponseData* appendData);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();
typedef void (^ProgressBlock)( CGFloat progress );
typedef void (^NetWorkBlock)(BOOL netConnetState);

@interface LostHttpClient : NSObject
{
}

DEFINE_SINGLETON_FOR_HEADER(LostHttpClient)

@property (nonatomic,assign) NetReachableType netReachableType;

// 网络状态变化监测
- (void)startMonitoringNetWorkState;

#pragma GET请求
+ (void) GETRequestURL: (NSString *) requestURLString
         WithParameter: (NSMutableDictionary *) parameter
  WithReturnValeuBlock: (ReturnValueBlock) block
      WithFailureBlock: (FailureBlock) failureBlock;

#pragma POST请求
+ (void) POSTRequestURL: (NSString *) requestURLString
          WithParameter: (NSMutableDictionary *) parameter
   WithReturnValeuBlock: (ReturnValueBlock) block
       WithFailureBlock: (FailureBlock) failureBlock;

+ (void) POSTFileURL: (NSString *) requestURLString
           parameter: (NSMutableDictionary *) parameter
            fileList: (NSArray*) arrayFile
            fileType: (PostSourceType)type
        successBlock: (ReturnValueBlock) block
       progressBlock: (ProgressBlock) uploadBlock
        failureBlock: (FailureBlock) failureBlock;

//多张图片并定义名字
+ (void) POSTFileURL: (NSString *) requestURLString
           parameter: (NSMutableDictionary *) parameter
            fileList: (NSArray*) arrayFile
            fileName: (NSArray*) fileNameArray
        successBlock: (ReturnValueBlock) block
       progressBlock: (ProgressBlock) uploadBlock
        failureBlock: (FailureBlock) failureBlock;

/// 检测是否为没有数据的错误
+ (void)checkResultError:(HttpResponseData*)data;

@end







