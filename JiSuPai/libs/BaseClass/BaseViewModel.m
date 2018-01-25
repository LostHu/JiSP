//
//  BaseViewModel.m
//  Football
//
//  Created by 崔伟战 on 15/11/27.
//  Copyright © 2015年 lost. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (id)init
{
    self = [super init];
    if (self) {
//        _dataLoadState = Loadnone;
//        @weakify(self)
//        [RACObserve([LostHttpClient sharedInstance], netReachableType) subscribeNext:^(id x) {
//            @strongify(self)
//            self.networkStatus = [x integerValue];
//            if (self.networkStatus == ReachableType_None) {
//#if Debug
//                [HUD showMsg:@"网络连接失败" type:HUDMsgType_Warning];
//#endif
//            }
//        }];
    }
    return self;
}

@end



@implementation BaseTableViewModel

- (id)init
{
    self = [super init];
    if (self) {
        _pageNo = 1;
        _array = [NSMutableArray new];
    }
    return self;
}

- (void)getFirstList:(ModelCompleteBlock)block
{
    self.pageNo = 1;
    [self getData:block];
}

- (NSString*)getListUrl
{
    return @"";
}

- (id)parseItem:(NSDictionary*)dic
{
    return nil;
}

- (void)addRequestParm:(NSMutableDictionary*)parameters
{
    
}

- (void)getData:(ModelCompleteBlock)block
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(self.pageNo) forKey:@"pageno"];
//    [parameters setObject:@(PageSize) forKey:@"pageSize"];
    [self addRequestParm:parameters];
    
    @weakify(self)
    [LostHttpClient GETRequestURL:[self getListUrl] WithParameter:parameters WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
        @strongify(self);
//        if (appendData.code == 200)
        {
            if (self.pageNo == 1) {
                self.bLast = NO;
                [self.array removeAllObjects];
            }
            
            NSMutableArray* mArray = [[NSMutableArray alloc] init];
            if (returnValue[@"rows"] && [returnValue[@"rows"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in returnValue[@"rows"])
                {
                    id data = [self parseItem:dic];
                    if (data) {
                        [mArray addObject: data];
                    }
                }
            }
            
            if (mArray.count < PageSize) {
                self.bLast = YES;
            }
            else
            {
                self.pageNo++;
            }
            
            if (_array) {
                [_array addObjectsFromArray:mArray];
                //                [mArray insertObjects:self.array atIndex:0];
            }
            self.array = _array;
            
            if (block) {
                block(nil,self.bLast);
            }
            return;
        }
//        else{
//            [HUD showMsg:appendData.msg type: HUDMsgType_Error];
//        }
        self.array = nil;
    } WithFailureBlock:^{
        self.array = nil;
    }];
}

@end
