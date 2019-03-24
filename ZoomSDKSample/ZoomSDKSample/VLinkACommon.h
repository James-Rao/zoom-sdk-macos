//
//  VLinkACommon.h
//  VLinkAMeeting
//
//  Created by limingzhan on 2019/1/9.
//  Copyright © 2019年 cn. All rights reserved.
//

#ifndef VLinkACommon_h
#define VLinkACommon_h

#ifdef DEBUG
#       define DLog(fmt, ...)  NSLog((@"" fmt),  ##__VA_ARGS__);
#       define BASEURL  @"http://218.17.76.147:9090"
#       define SOCKETIO @"http://218.17.76.147:9091"
#else
#       define DLog(...)
#       define BASEURL  @"http://218.17.76.147:9090"
#       define SOCKETIO @"http://218.17.76.147:9091"
#endif

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(750,1624), [[UIScreen mainScreen] currentMode].size)): NO)

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) isEqualToString:@""]))

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width

#define GetHeight(h)  (h) * kScreenWidth / 320.0f
#define GetWidth(w)   (w) * kScreenWidth / 320.0f

#define Get375Height(h)  (h) * kScreenWidth / 375.0f
#define Get375Width(w)   (w) * kScreenWidth / 375.0f

#define kDeviceWidth    (kScreenWidth<kScreenHeight?kScreenWidth:kScreenHeight)
#define kDeviceHeight   (kScreenWidth<kScreenHeight?kScreenHeight:kScreenWidth)

//iPhoneX顶部部偏移量
#define Top_SN_iPhoneX_SPACE            (iPhoneX ? 24.f : 0)

//iPhoneX底部偏移量
#define Bottom_SN_iPhoneX_SPACE         (iPhoneX ? 34.f : 0)

//iPhoneX navigationview底部Y坐标
#define NavigationBar_Bottom_Y     (iPhoneX ? 88.0 : 64.0)

//==================================================
// 判断是否为iPhone X 系列(XMax XR XS)
#define IPHONE_X_OR_LATER \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

//iPhoneX顶部部偏移量
#define Top_SN_iPhoneX_OR_LATER_SPACE            (IPHONE_X_OR_LATER ? 24.f : 0)

//iPhoneX底部偏移量
#define Bottom_SN_iPhoneX_OR_LATER_SPACE         (IPHONE_X_OR_LATER ? 34.f : 0)

#define VLinkFont(fontsize)  [UIFont fontWithName:@"PingFangSC-Regular" size:(fontsize)]
#define VLinkFont2(fontsize) [UIFont fontWithName:@"SIL-Hei-Med-Jian" size:(fontsize)]

#define VLWeakSelf(weakSelf) __weak __typeof(self) weakSelf = self;
#define UIColorFromRGB(rgbValue, ap) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:ap]
#define VLIMAGEBY(name)  [UIImage imageNamed:(name)]

#define USERSTATUS(type)  (type==USERSTATUS_MOBILE_ONLINE||type==USERSTATUS_PC_ONLINE||type==USERSTATUS_STB_ONLINE)?@"在线":(type==USERSTATUS_OFFLINE)?@"离线":(type==USERSTATUS_INMEETING)?@"会议中":@"未知"
#define COLORBYUSERSTATUS(type)  (type==USERSTATUS_MOBILE_ONLINE||type==USERSTATUS_PC_ONLINE||type==USERSTATUS_STB_ONLINE)?UIColorFromRGB(0x77A73A, 1):(type==USERSTATUS_OFFLINE)?UIColorFromRGB(0xAEAEAE, 1):(type==USERSTATUS_INMEETING)?UIColorFromRGB(0xE13B00, 1):UIColorFromRGB(0xAEAEAE, 1)
#define IMAGEBYUSERSTATUS(type)  (type==USERSTATUS_MOBILE_ONLINE)?@"state_icon_phone_focus":\
                                 (type==USERSTATUS_PC_ONLINE)?@"state_icon_computer":\
                                 (type==USERSTATUS_STB_ONLINE)?@"state_icon_bigscreen":\
                                 (type==USERSTATUS_OFFLINE)?@"state_icon_offline":\
                                 (type==USERSTATUS_INMEETING)?@"state_icon_mettings":@""

#define ErrorMessage(_response) [(_response) objectForKey:@"message"];
#define MBPHUDAutoHide(_toView, _animated, _message)\
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:(_toView) animated:(_animated)];\
                        hud.mode = MBProgressHUDModeText;\
                        hud.detailsLabel.text = (_message);\
                        [hud hideAnimated:(_animated) afterDelay:2];\

typedef void(^Block)(void);

typedef NS_ENUM(NSInteger, VLTerminalType)
{
    TERMINALTYPE_MOBILE  = 0,
    TERMINALTYPE_PC,
    TERMINALTYPE_STB,
};

typedef NS_ENUM(NSInteger, VLTerminalStatus)
{
    TERMINALSTATUS_OFFLINE = 0,         // 离线
    TERMINALSTATUS_ONLINE,              // 在线
    TERMINALSTATUS_INMEETING            // 会议中
};

typedef NS_ENUM(NSInteger, VLUserStatus)
{
    USERSTATUS_MOBILE_ONLINE = 0,
    USERSTATUS_PC_ONLINE,
    USERSTATUS_STB_ONLINE,
    USERSTATUS_OFFLINE,
    USERSTATUS_INMEETING,
};

typedef NS_ENUM(NSInteger, VLMeetingStatus)
{
    MEETING_STATUS_IDLE, /// <Idle status means no meeting is running.
    MEETING_STATUS_CONNECTING, /// <Connecte to the meeting server status.
    MEETING_STATUS_WAITINGFORHOST, /// <Waiting for the host to start the meeting.
    MEETING_STATUS_INMEETING, /// <Meeting is ready, in meeting status.
    MEETING_STATUS_DISCONNECTING, /// <Disconnecte the meeting server, leave meeting status.
    MEETING_STATUS_RECONNECTING, /// <Reconnecting meeting server status.
    MEETING_STATUS_FAILED, /// <Failed to connect the meeting server.
    MEETING_STATUS_ENDED, /// <Meeting ends.
    MEETING_STATUS_UNKNOW, /// <Unknown status.
    MEETING_STATUS_LOCKED, /// <Meeting is locked to prevent the further participants to join the meeting.
    MEETING_STATUS_UNLOCKED, /// <Meeting is open and participants can join the meeting.
    MEETING_STATUS_IN_WAITING_ROOM, /// <Participants who join the meeting before the start are in the waiting room.
    MEETING_STATUS_WEBINAR_PROMOTE, /// <Upgrade the attendees to panelist in webinar.
    MEETING_STATUS_WEBINAR_DEPROMOTE, /// <Downgrade the attendees from the panelist.
    MEETING_STATUS_JOIN_BREAKOUT_ROOM, /// <Join the breakout room.
    MEETING_STATUS_LEAVE_BREAKOUT_ROOM, /// <Leave the breakout room.
    MEETING_STATUS_WAITING_EXTERNAL_SESSION_KEY,/// <Waiting for the additional secret key.
};

#endif /* VLinkACommon_h */
