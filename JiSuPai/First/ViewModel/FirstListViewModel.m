//
//  FirstListViewModel.m
//  JiSuPai
//
//  Created by Lost on 2018/1/17.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "FirstListViewModel.h"

@implementation FirstListViewModel
- (void)addRequestParm:(NSMutableDictionary*)parameters
{
    //    [parameters setObject:self.doc_id forKey:@"tId"];
}

- (NSString*)getListUrl
{
    return API_FirstList;
}

- (id)parseItem:(NSDictionary*)dic
{
    TaskData *data = [TaskData modelWithDictionary: dic];
    return data;
}
@end
