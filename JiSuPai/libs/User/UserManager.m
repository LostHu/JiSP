//
//  UserManager.m
//  Lust
//
//  Created by Lost on 16/4/12.
//  Copyright © 2016年 Lost. All rights reserved.
//

#import "UserManager.h"

#define kFistOpenApp    @"kFistOpenApp"
#define MyDB            @"my_db"
#define CACHEKEY_MyInfoData   @"CACHEKEY_MyInfoData"
#define CACHEKEY_UserLoginName    @"CACHEKEY_UserLoginName"
#define CACHEKEY_UserPWD    @"CACHEKEY_UserPWD"

@implementation UserManager
DEFINE_SINGLETON_FOR_CLASS(UserManager)

- (id)init
{
    @synchronized(self) {
        self = [super init];//往往放一些要初始化的变量.
        
        UserData* userdata = [self readCacheStoreUserDataForKey:CACHEKEY_MyInfoData];
        if (userdata && [userdata isKindOfClass:[UserData class]])
        {
            _userData = userdata;
            
            YYCache *cache = [YYCache cacheWithName:MyDB];
            NSString* name = (NSString*)[cache objectForKey:CACHEKEY_UserLoginName];
            NSString* pwd = (NSString*)[cache objectForKey:CACHEKEY_UserPWD];
            if (![NSString isBlankString:name]) {
                _loginname = name;
            }
            if (![NSString isBlankString:pwd]) {
                _password = pwd;
            }
        }
        else
        {
            [[YYCache cacheWithName:MyDB] removeObjectForKey:CACHEKEY_UserLoginName];
            [[YYCache cacheWithName:MyDB] removeObjectForKey:CACHEKEY_UserPWD];
        }
        
        return self;
    }
}

- (BOOL)hasAccount
{
    return ![NSString isBlankString:self.loginname];
}
//
//- (BOOL)isTemporaryAccount
//{
//    if (_token && _userData.status == 0)
//    {
//        return YES;
//    }
//    return NO;
//}
//
//- (BOOL)isLegalAccount
//{
//    return [self hasAccount] && ![self isTemporaryAccount];
//}
//
//- (BOOL)isSameUser:(NSString*)userId
//{
//    if (_userData && ![NSString isBlankString:_userData.userId]) {
//        return [_userData.userId isEqualToString:userId];
//    }
//    return NO;
//}
//
- (void)setLoginname:(NSString *)loginname
{
     _loginname = loginname;
    if (![NSString isBlankString:loginname]) {

        [[YYCache cacheWithName:MyDB] setObject:_loginname forKey:CACHEKEY_UserLoginName];
    }
}

- (void)setPassword:(NSString *)password
{
    _password = password;
    if (![NSString isBlankString:password]) {
        [[YYCache cacheWithName:MyDB] setObject:_password forKey:CACHEKEY_UserPWD];
    }
}

- (void)setUserData:(UserData *)userData
{
    if (userData) {
        [self writeTheUserdata:userData];
    }
    else
    {
        self.loginname = nil;
        self.password = nil;
        [[YYCache cacheWithName:MyDB] removeObjectForKey:CACHEKEY_UserLoginName];
        [[YYCache cacheWithName:MyDB] removeObjectForKey:CACHEKEY_UserPWD];
        [[YYCache cacheWithName:MyDB] removeObjectForKey:CACHEKEY_MyInfoData];
    }
    _userData = userData;
}

-(UserData *)readCacheStoreUserDataForKey:(NSString *)cacheKey
{
    YYCache *cache = [YYCache cacheWithName:MyDB];
    UserData *data = (UserData *)[cache objectForKey:cacheKey];
    return data;
}

- (void) writeTheUserdata:(UserData *)userData
{
    YYCache *cache = [YYCache cacheWithName:MyDB];
    [cache setObject:userData forKey:CACHEKEY_MyInfoData];
}

- (void)clearUserData
{
    self.userData = nil;
}

//- (BOOL)hasAuthforURL:(NSString*)url
//{
//    BOOL bNeedAuth = NO;
//    NSArray* array = @[API_PostGameHomeComment,         // 发布游戏首页评论
//                       API_PostGameComment,             // 发布游戏评论
//                       API_LikeGameRaiders,             // 点赞游戏攻略
//                       API_SaveGameRaiders,             // 收藏游戏攻略
//                       API_LikeGameRaidersComment,      // 点赞游戏攻略评论
//                       API_DeleteRaidersComment,        // 删除攻略评论
//                       API_UpdateFollowGameState,       // 更新游戏的收藏状态
//                       API_GainGameGift,                // 礼包领取
//                       API_GameCommentLike,             // 游戏内页点赞
//                       API_SueGame,                     // 催更小编
//                       API_ConsultLike,                 // 资讯点赞
//                       API_ConsultCollect,              // 资讯收藏
//                       API_LikeConsultComment,          // 资讯回复点赞
//                       ];
//    for (NSString* aUrl in array) {
//        if ([aUrl isEqualToString:url]) {
//            bNeedAuth = YES;
//            break;
//        }
//    }
//
//    if (bNeedAuth && ![self hasAccount]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName: Notify_NeedLogin
//                                                            object:self
//                                                          userInfo:@{@"AppSystemEventType":@(ShowLogin),
//                                                                     @"SuccessStatue":@(YES)}];
//        return NO;
//    }
//
//    return YES;
//}

- (void)getUserDatafromNetWork
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [LostHttpClient GETRequestURL:API_accountInfo WithParameter:parameters WithReturnValeuBlock:^(id returnValue, HttpResponseData *appendData) {
        if (appendData.flag == YES) {
            UserData *data = [UserData modelWithDictionary:returnValue[@"data"]];
            self.userData = data;
        }else{
            [HUD showMsg:appendData.msg type: HUDMsgType_Error];
        }
        
    } WithFailureBlock:^{
    }];
}

//- (NSMutableDictionary*)getParameters
//{
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setObject:self.token  forKey:@"token"];
//    
//    return parameters;
//}

@end
