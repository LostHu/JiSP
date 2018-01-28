//
//  HttpTask.m
//  Football
//
//  Created by lost on 15/7/15.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "HttpTask.h"

@implementation HttpTask

@end

@implementation HttpResponseData

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[@"code"] isKindOfClass:[NSNull class]]){
        self.code = [dictionary[@"code"] integerValue];
    }
    
//    if(![dictionary[@"flag"] isKindOfClass:[NSNull class]]){
//        self.flag = [dictionary[@"flag"] boolValue];
//    }
    
    if(![dictionary[@"result"] isKindOfClass:[NSNull class]]){
        self.flag = [dictionary[@"result"] isEqualToString:@"true"];
    }
    
    if(![dictionary[@"msg"] isKindOfClass:[NSNull class]]){
        self.msg = dictionary[@"msg"];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[@"code"] = @(self.code);
    dictionary[@"flag"] = @(self.flag);
    if(self.msg != nil){
        dictionary[@"msg"] = self.msg;
    }
    return dictionary;
    
}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:@(self.code) forKey:@"code"];	[aCoder encodeObject:@(self.flag) forKey:@"flag"];	if(self.msg != nil){
        [aCoder encodeObject:self.msg forKey:@"msg"];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.code = [[aDecoder decodeObjectForKey:@"code"] integerValue];
    self.flag = [[aDecoder decodeObjectForKey:@"flag"] boolValue];
    self.msg = [aDecoder decodeObjectForKey:@"msg"];
    return self;
    
}

@end
