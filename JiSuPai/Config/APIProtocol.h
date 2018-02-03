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
#define API_userprotoco     FormatStr(@"%@%@",H5BaseUrl_Dev,@"userprotocol.htm")     //用户协议
#define API_share           @"share.html"           //分享
#define API_Feedback        DriverPrefix(@"/createFankui.do")//反馈
#define API_PostPhoto       DriverPrefix(@"/submitZhengjianPic.do")//上传证件照片

















