//
//  ListDataVM.m
//  GTarcade
//
//  Created by VisonCui on 2017/12/28.
//  Copyright © 2017年 VisonCui. All rights reserved.
//

#import "ListDataVM.h"

@interface ListDataVM()

@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic, copy) ParseItemBlock parseBlock;
@property (nonatomic, strong) NSDictionary *parDic;

@end

@implementation ListDataVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageNo = 1;
        _array = [NSMutableArray new];
    }
    return self;
}

//- (NSString*)getListUrl
//{
//    return @"";
//}
//
//- (id)parseItem:(NSDictionary*)dic
//{
//    return nil;
//}
//
//- (void)addRequestParm:(NSMutableDictionary*)parameters
//{
//
//}

-(void)setListUrl:(NSString *)urlStr requestParmDic:(NSDictionary *)parmDic
{
    _urlStr = urlStr;
    _parDic = parmDic;
//    self.parseBlock = block;
}

-(id)parseItem:(NSDictionary*)dic
{
//    (ParseItemBlock)block
//    return parseBlock(dic,nil);
    return  nil;
}

- (void)getData:(ModelCompleteBlock)block
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(self.pageNo) forKey:@"pageNo"];
    [parameters setObject:@(PageSize) forKey:@"pageSize"];
    
    for (NSString *key in _parDic.allKeys)
    {
        NSString *value = [_parDic objectForKey:key];
        [parameters setObject:value forKey:key];
    }
    
    @weakify(self)
    [LostHttpClient GETRequestURL:_urlStr WithParameter:parameters WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
        @strongify(self);
        if (appendData.code == 200) {
            if (self.pageNo == 1) {
                self.bLast = NO;
                [self.array removeAllObjects];
            }
            
            NSMutableArray* mArray = [[NSMutableArray alloc] init];
            if (returnValue[@"data"] && [returnValue[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in returnValue[@"data"])
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
        }else{
            [HUD showMsg:appendData.msg type: HUDMsgType_Error];
        }
        self.array = nil;
    } WithFailureBlock:^{
        self.array = nil;
    }];
}


@end
