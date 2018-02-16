//
//  TiXianTableViewModel.m
//  JiSuPai
//
//  Created by Lost on 2018/2/8.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TiXianTableViewModel.h"

@implementation TixianData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"tixianId" : @"id"};
}
@end

@implementation TiXianTableViewModel

- (void)addRequestParm:(NSMutableDictionary*)parameters
{
    //    [parameters setObject:self.doc_id forKey:@"tId"];
}

- (NSString*)getListUrl
{
    return API_GetRequestCashList;
}

- (id)parseItem:(NSDictionary*)dic
{
    TixianData *data = [TixianData modelWithDictionary: dic];
    return data;
}
@end
