//
//  HttpTask.h
//  Football
//
//  Created by lost on 15/7/15.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTask : NSObject

@end


@interface HttpResponseData : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, strong) NSString * msg;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end