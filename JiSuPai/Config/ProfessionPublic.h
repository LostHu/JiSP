//
//  ProfessionPublic.h
//  GTarcade
//
//  Created by VisonCui on 2017/12/25.
//  Copyright © 2017年 VisonCui. All rights reserved.
//

#ifndef ProfessionPublic_h
#define ProfessionPublic_h

#define LS(name)                   NSLocalizedString(name, nil)         // 本地化字符串

#define kUserDefaultsForUserPhone       @"UserDefaultsForUserPhone"
#define kUserDefaultsGotoAppstoreTime       @"UserDefaultsGotoAppstoreTime"
#define kUserDefaultsGotoAppstoreCount       @"UserDefaultsGotoAppstoreCount"

#define Notify_AppSystemEvent   @"Notify_AppSystemEvent"
#define Notify_ShowUserHomePage @"Notify_ShowUserHomePage"          // 用户个人中心
#define Notify_NavToMePage      @"Notify_NavToMePage"
#define Notify_ShowGamePage     @"Notify_ShowGamePage"              // 游戏主页
#define Notify_ShowArticlePage  @"Notify_ShowArticlePage"           // 文章攻略页
#define Notify_ShowMessage      @"Notify_ShowMessage"
#define Notify_ShowInfoPage     @"Notify_ShowInfoPage"              // 资讯详情页
#define Notify_ShowInfoCollectionPage     @"Notify_ShowInfoCollectionPage"  // 某个游戏资讯集合
#define Notify_NeedLogin        @"Notify_NeedLogin"


typedef NS_ENUM(NSInteger, NeedLoginEvent)
{
    ShowLogin = 0,          // 需要显示登录view
    HideLogin,              // 需要隐藏登录View
};

typedef enum
{
    Login_Event = 0,          // 登录事件
    Logout_Event,             // 登出
    NavToPage_Event,          // 导航事件
} AppSystemEvent;

//typedef NS_ENUM(NSInteger, HomeCardDataType)
//{
//    Text        = 1,    // 文本
//    Photo       = 2,    // 图片
//    Audio       = 3,    // 音频
//    Video       = 4,    // 视频
//};

// 发现类型
typedef NS_ENUM(NSInteger, EventType)
{
    EventType_Topic     = 0,    // 话题
    EventType_Gift      = 1,    // 礼包
    EventType_Video     = 2,    // 视频
};

typedef NS_ENUM(NSInteger, SourceType)
{
    SourceType_Game             = 0,    // 游戏
    SourceType_Article          = 1,    // 攻略
    SourceType_Infomation       = 2,    // 资讯
    SourceType_CompileEveryDay  = 3,    // 小编日常
};

typedef NS_ENUM(NSInteger, PostSourceType)
{
    PostSourceType_Text     = 0,        // 文本
    PostSourceType_Photo    = 1 << 0,   // 图片
    PostSourceType_Audio    = 1 << 1,   // 音频
    PostSourceType_Video    = 1 << 2,   // 视频
};

typedef NS_ENUM(NSInteger, MessageDataType)
{
    MsgType_LevelUp         = 0,    // 等级提升
    MsgType_Follow          = 1,    // 某人关注了你
    MsgType_Comment4Game    = 2,    // 某人回复了你的游戏评论
    MsgType_Comment4Doc     = 3,    // 某人回复了你的攻略评论
    MsgType_Comment4Info    = 4,    // 某人回复了你的攻略评论
    MsgType_Comment4Compile = 5,    // 某人回复了你的小编日常评论
};

typedef NS_ENUM(NSInteger, RelationType)
{
    RelationType_None        = 0,        // 没关系
    RelationType_Fans        = 1 << 0,   // 我的粉丝1
    RelationType_Concern     = 1 << 1,   // 我关注的2
    RelationType_Friend      = RelationType_Fans | RelationType_Concern,   // 互相关注3
};


#endif /* ProfessionPublic_h */
