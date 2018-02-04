//
//  UserData.m
//  Lust
//
//  Created by Lost on 16/4/12.
//  Copyright © 2016年 Lost. All rights reserved.
//

#import "UserData.h"


@implementation UserData



//- (BOOL)isBanAccount
//{
//    return self.type == 2;
//}

//@"这家伙很懒 什么都没有留下"
//- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
//    NSString *titleStr = dic[@"signature"];
//    _signature =  [NSString isBlankString:titleStr] ? @"这家伙很懒 什么都没有留下" : titleStr;
//
//    return YES;
//}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    return [self modelInitWithCoder:aDecoder];
}


- (id)copyWithZone:(NSZone *)zone
{
    return [self modelCopy];
}

@end
