//
//  APIProtocol.h
//  Lust
//  Created by lost on 15/7/15.
//  Copyright (c) 2015年 lost. All rights reserved.
//

/**
 0: 后台本机
 1: 内网服务器
 2: 外网服务器
 */

#define AppDevURLLog     1

#define AppBaseUrl       (AppDevURLLog == 1) ? AppBaseUrl_Dev : ((AppDevURLLog == 0) ? AppBaseUrl_benji : AppBaseUrl_Wai)
#define H5BaseUrl        (AppDevURLLog == 1) ? H5BaseUrl_Dev : ((AppDevURLLog == 0) ? H5BaseUrl_benji : H5BaseUrl_Wai)

#define AppBaseUrl_Dev @"http://101.132.76.40/jisupai/"                  // 内网服务器
#define H5BaseUrl_Dev  @"http://101.132.76.40/jisupai/"                     // 内网 H5

#define AppBaseUrl_benji @"http://192.168.43.135:8080/gameplus-app"          // 本机服务器
#define H5BaseUrl_benji  @"http://10.18.97.194/share"             // H5

#define AppBaseUrl_Wai @"https://plus-manager.youzu.com/gameplus"        // 外网服务器
#define H5BaseUrl_Wai  @"https://plus.youzu.com/share"                  // 外网 H5
//#define H5BaseUrl_Wai  @"https://bb.youzu.com/v1"               // 外网 H5
//#define AppBaseUrl_Wai @"https://plus-manager.youzu.com/gamebibi"       // 外网服务器

// 友盟参数配置
#define UMengAppKey         @"599510638630f572750015c9"     // gamebibi

#define API_Prefix_Driver   @"appdriver/"
#define DriverPrefix(f) FormatStr(@"appdriver/%@",f)

// 任务列表
#define API_TaskList                    DriverPrefix(@"getTaskOrders.do")                        // 主页面接口
#define API_TaskStart                   DriverPrefix(@"startWork.do")                   // 游戏列表
#define API_TaskEnd                     DriverPrefix(@"endWork.do")                 // 游戏详情页
// 抢单列表
#define API_FirstList                   DriverPrefix(@"getNoDriverOrders.do")                 // forumList
#define API_MatchOrder                  DriverPrefix(@"matchOrder.do")
#define API_CancelOrder                 DriverPrefix(@"cancelOrder.do")
// 历史订单
#define API_CompleteTaskList            DriverPrefix(@"getCompletedTask.do")                 // forumList
#define API_CompleteSubTaskList         DriverPrefix(@"getCompletedOrderByTask.do")
// 正在进行订单
#define API_WorkingTask                 DriverPrefix(@"getWorkingOrder.do")                 // forumList
#define API_PostWorkingException        DriverPrefix(@"exception.do")
#define API_WorkingExceptionList        @"appcommon/getDictionarySelect.do?classname=orders&attribute=exception"

// 提现
#define API_GetRequestCashList          DriverPrefix(@"getTixianRecords.do")
#define API_RequestCash                 DriverPrefix(@"shenqingTixian.do")

// 空闲时间
#define API_FreeList                    DriverPrefix(@"getFreTime.do")
#define API_AddFreeTime                 DriverPrefix(@"createFreeTime.do")
#define API_DeleteFreeTime              DriverPrefix(@"deleteFreeTime.do")

// 请假
#define API_LeaveList                    DriverPrefix(@"getLeave.do")
#define API_AddLeaveTime                 DriverPrefix(@"createLeave.do")
#define API_DeleteLeaveTime              DriverPrefix(@"deleteLeave.do")

// 司机信息
#define API_GetDriverInfo               DriverPrefix(@"getDriverInfo.do")
#define API_PostDriverInfo              DriverPrefix(@"submitDriverInfo.do")
#define API_GetCarTypeList              @"appcommon/getDictionarySelect.do?classname=driver&attribute=cartype"

//用户
#define API_login           DriverPrefix(@"login.do")       //登陆
#define API_registerHuozhu  DriverPrefix(@"register.do")    //注册
#define API_sendPhoneCode   @"appcommon/sendPhoneCode.do"  //发送手机验证码
#define API_resetPassword   @"appcommon/resetPassword.do"  //修改密碼
#define API_sendLocation    @"appcommon/pushZuobiao.do"    //发送坐标
#define API_accountInfo     DriverPrefix(@"accountInfo.do") //账户信息
#define API_Edit_Account    DriverPrefix(@"submitDriverInfo.do") //编辑驾驶信息
#define API_getMyPingjia    DriverPrefix(@"getMyPingjia.do")//客户评价
#define API_sjxy            FormatStr(@"%@%@",H5BaseUrl_Dev,@"driverschool.html")    //司机学院
#define API_userprotoco     @"userprotocol.htm"     //用户协议
#define API_share           @"share.html"           //分享
#define API_Feedback        DriverPrefix(@"/createFankui.do")//反馈
#define API_PostPhoto       DriverPrefix(@"/submitZhengjianPic.do")//上传证件照片


















// 配置
#define API_GetConfig               @"/member/api_get_config"

#define API_Version                 @"/login/version"                   // 强制更新请求
//// 登录
#define API_LoginFirst              @"/login/first"                     // 申请临时账号
#define API_Login                   @"/login"                           // 获取验证码
#define API_GetCode                 @"/login/get_code"                  // 登录
#define API_GetGameInfoList         @"/game/getGameInfoList"            // 首页列表
#define API_GetGameInfoDetail       @"/game/getGameInfoDetail"          // Detail 1
#define API_GetGameComponentList    @"/game/getGameComponentList"       // Detail 2 组件
#define API_GetGameCommentInfo      @"/game/getGameCommentInfo"         // 评论列表
#define API_GetGameComponentDetail  @"/game/getGameComponentDetail"     // 组件列表
#define API_GetGameWtListByGameId   @"/game/getGameWalkthroughListByGameId" // 最新攻略列表
#define API_PostGameHomeComment     @"/game/postGameComment"            // 发布游戏评论
#define API_DeleteGameComment       @"/game/deleteGameComment"          // 删除游戏评论
#define API_GameCommentLike         @"/game/gameCommentLike"            // 游戏评论点赞
#define API_GetGameGiftList         @"/game/getGameGiftList"            // 游戏礼包列表
#define API_GetGameGift             @"/game/getGameGift"                // 游戏礼包详情 
#define API_GainGameGift            @"/game/gainGameGift"               // 游戏礼包领取 
#define API_GetGameCommentReplyInfo @"/game/getGameCommentReplyInfo"    // 游戏回复详情
#define API_GetGameComUserLikeList  @"/game/getGameCommentUserLikeList" // 游戏回复点赞列表
#define API_GetGameCommentReplyListInfo @"/game/getGameCommentReplyListInfo" // 游戏回复列表

#define API_GetGameWalkthroughCommentReplyInfo @"/game/getGameWalkthroughCommentReplyInfo" // 文章回复详情
#define API_GetGameWalkthroughCommentReplyListInfo @"/game/getGameWalkthroughCommentReplyListInfo"   // 文章回复列表
#define API_GetGameWalkthroughCommentUserLikeList  @"/game/getGameWalkthroughCommentUserLikeList"    // 文章评论详情点赞列表

// 攻略操作
#define API_PostGameComment         @"/game/postGameWalkthroughComment"     // 发布评论
#define API_LikeGameRaiders         @"/game/gameWalkthroughLike"            // 点赞攻略
#define API_SaveGameRaiders         @"/game/gameWalkthroughCollect"         // 收藏攻略
#define API_LikeGameRaidersComment  @"/game/gameWalkthroughCommentLike"     // 点赞文章评论
#define API_DeleteRaidersComment    @"/game/deleteGameWalkthroughComment"   // 删除文章评论
#define API_GetRaidersComment       @"/game/getGameWalkthroughCommentInfo"  // 获取文章评论
#define API_GetRaidersParm          @"/game/getWalkthroughCount"            // 获取文章点赞信息

// 资源上传图片
#define API_UploadResource          @"/upload/image"

// 编辑发布
#define API_EditorPost              @"/editor/add"
#define API_EditorList              @"/editor/list"                         // 编辑日常列表

// 活动
#define API_GetActivityGameList     @"/game/v3/getActivityInfo"             // 获取活动首页数据

// 资讯
#define H5_MyWealth                 [H5BaseUrl stringByAppendingString:@"/myWealth/index.html?number="]
#define H5_LevelInfo                [H5BaseUrl stringByAppendingString:@"/describe/index.html"]
#define H5_P_Rule                   [H5BaseUrl stringByAppendingString:@"/rules/index.html"]

/// 用户
#define API_GetUserInfo             @"/user/getUserInfo"
#define API_EditUserInfo            @"/user/update_user"
#define API_FeedBack                @"/user/feedBack"
#define API_FollowUser              @"/user/userAttation"               // 关注/取消关注用户
#define API_GetFollowUserList       @"/user/getUserAttentionList"       // 获取我关注的用户列表
#define API_GetFansUserList         @"/user/getUserFansList"            // 获取关注我的粉丝列表
/// 用户关注游戏
//#define API_GetUserFollow           @"/game/getGameInfoListByInterest"          // 用户关注的游戏
#define API_UpdateFollowGameState   @"/game/gameInterest"                       // 用户关注/取消关注游戏
#define API_SueGame                 @"/user/userComplain"                       // 用户投诉游戏
#define API_GetUserFollow           @"/game/getGameInterestInfo"                // 用户关注的游戏列表
#define API_GetUserGameConsult      @"/game/consult/getGameConsultCollectList"  // 用户关注的资讯列表
#define API_GetUserRaiders          @"/game/getGameWalkthroughCollectAndLike"   // 用户关注的攻略游戏列表
#define API_GetUserGameRaiders      @"/game/getGameWalkthroughCollectList"      // 用户关注的游戏攻略列表
#define API_GetMyGifts              @"/game/getGameGiftByUserId"                // 用户的礼包列表

#define API_GameRecommendMarketList @"/game/getGameRecommendListByUpLine"       // 新游推荐已上线列表
#define API_GameRecommendList       @"/game/getGameRecommendList"               // 新游推荐列表
#define API_GameRecommendLike       @"/game/gameRecommendLike"                  // 新游推荐列表点赞
#define API_GameRecommend           @"/game/gameRecommend"                      // 新游推荐

#define API_GetUserMessageList      @"/user/getUserMessageList"                 // 消息列表
#define API_GetUserMessageStatus    @"/user/getUserMessageStatus"               // 消息状态

#define API_GetUserSignList         @"/user/getUserSignInList"                  // 签到列表
#define API_GetUserSignInStatus     @"/user/getUserSignInStatus"                // 签到状态
#define API_Sign                    @"/user/userSignIn"                         // 签到

#define API_GetUserLotteryState     @"/user/lottery_status"                     // 获取抽奖状态
#define API_GetUserLottery          @"/user/lottery"                            // 抽奖

#define API_GetUserComment          @"/game/getGameCommentListByUserId"         // 用户的礼包列表
#define H5_ShareGift                [H5BaseUrl stringByAppendingString:@"/gift/index.html?gameGiftId="]
#define H5_ShareInfo                [H5BaseUrl stringByAppendingString:@"/consultDetail/index.html?gameConsultId="]

// 游戏特攻
#define API_GetGameSpecialAttack    @"/index"            // 首页

// 新游推荐
#define API_GetGameRecommendList    @"/game/scheduling"

// 资讯
#define API_GetConsultList          @"/game/consult/getConsultList"             // 游戏资讯
#define API_GetGameConsultList      @"/game/consult/getGameConsultListByGameId" // 获取某游戏的资讯列表
#define API_GetConsultCommentList   @"/game/consult/getGameConsultCommentInfo"  // 获取资讯的评论列表
#define API_GetGameConsultDetail    @"/game/consult/getGameConsultDetail"       // 资讯详情
#define API_ConsultCollect          @"/game/consult/consultCollect"             // 资讯收藏
#define API_ConsultLike             @"/game/consult/consultLike"                // 资讯点赞
#define API_PostConsultComment      @"/game/consult/postConsultComment"         // 发布资讯评论
#define API_DeleteConsultComment    @"/game/consult/deleteConsultComment"       // 删除资讯评论
#define API_LikeConsultComment      @"/game/consult/consultCommentLike"         // 资讯评论点赞
#define API_GetConsultCommentReplyInfo    @"/game/consult/getConsultCommentReplyInfo" // 资讯评论回复详情
#define API_GetConsultCommentReplyList    @"/game/consult/getConsultCommentReplyList" // 资讯评论回复列表
#define API_GetGameConsultCommentUserLikeList  @"/game/consult/getGameConsultCommentUserLikeList" // 资讯评论点赞列表

#define API_GetHonorList            @"/top/honor"  // 荣誉榜

#define API_GetEditorInfo    @"/editor/getEditorInfo"          // 小编日常详情
#define API_EditorLike       @"/editor/like"                  // 小编日常点赞
#define API_EditorDelete       @"/editor/delete"                  // 小编日常删除
#define API_EditorCommentList       @"/editor/comment/list"            // 小编日常评论列表
#define API_EditorCommentInfo       @"/editor/comment/info"           // 编辑日常评论详细信息
#define API_EditorCommentAdd           @"/editor/comment/add"        //添加编辑日常评论
#define API_EditorReplyList           @"/editor/comment/reply/list"   // 编辑日常评论回复列表
#define API_EditorLikeList           @"/editor/comment/like/list"     //评论点赞用户列表
#define API_EditorCommentDelete           @"/editor/comment/delete"          // 编辑日常评论删除
#define API_EditorCommentLike           @"/editor/comment/like"           // 编辑日常评论点赞
