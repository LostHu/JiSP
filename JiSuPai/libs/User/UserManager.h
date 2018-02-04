//
//  UserManager.h
//  Lust
//
//  Created by Lost on 16/4/12.
//  Copyright © 2016年 Lost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserData.h"

@interface UserManager : NSObject
DEFINE_SINGLETON_FOR_HEADER(UserManager)

@property (nonatomic, strong) UserData*  userData;
@property (nonatomic, strong, readwrite) NSString*  loginname;
@property (nonatomic, strong, readwrite) NSString*  password;


/**
 *  返回是否有账号存在，用于启动判定
 *
 *  @return bool
 */
//- (BOOL)isTemporaryAccount;                     // 是否为临时账号
//- (BOOL)hasAccount;
//// 是否是合法账号，非以上2种账号
//- (BOOL)isLegalAccount;
- (void)getUserDatafromNetWork;
//- (NSMutableDictionary*)getParameters;

- (void)clearUserData;
//- (BOOL)isSameUser:(NSString*)userId;

// token存在接口判断
//- (BOOL)hasAuthforURL:(NSString*)url;
//
//- (void)firstOpenToGetAccount;
@end
