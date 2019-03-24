//
//  VLSocketIO.h
//  VLinkAMeeting
//
//  Created by lxf on 2019/1/18.
//  Copyright © 2019 cn. All rights reserved.
//

#import <Foundation/Foundation.h>
@import SocketIO;

@class UserInfo;
@class TerminalInfo;
@class MeetingInfo;
@class InvitationInfo;
@class SocketAckEmitter;

typedef NS_ENUM(NSInteger, VLNotificationType)
{
    VLNotificationTypeInvited  = 0,      // 注册邀请通知
    VLNotificationTypeContactUpdate,     // 注册联系人状态变化通知
    VLNotificationTypeOtherLogin,        // 相同账号在其他同类型 logout并返回login界面，提示账设备登录
};

#define NotificationInvitedName       @"invited_join_meeting"
#define NotificationStatusUpdateName  @"contact_status_changed"
#define NotificationStatusOtherLogin  @"other_terminal_connected"

NS_ASSUME_NONNULL_BEGIN

typedef void (^SocketIOCallback)(NSArray * _Nonnull, SocketAckEmitter * _Nonnull);
typedef void (^SocketIOHandle)(void);
typedef SocketIOHandle SocketIOComplete;

@protocol VLSocketIODelegate <NSObject>

@required
- (void)OnConnect:(BOOL)success;
- (void)UserLogin:(UserInfo *)userInfo;
//- (void)JoinMeeting:(InvitationInfo *)invitationInfo;
//- (void)ContactStatucChange:(UserInfo *)UserInfo;

@end

@interface VLSocketIO : NSObject

+ (VLSocketIO *)shareManager;

- (void)setDelegate:(id<VLSocketIODelegate>)delegate;

- (void)connectTimeout:(double)timeoutAfter WithHandler:(SocketIOHandle)handler;

- (void)disconnect;

- (void)terminalInfoUpdate:(TerminalInfo*)terminalInfo WithComplete:(SocketIOComplete)complete;

- (void)inviteContactsMeeting:(MeetingInfo*)meetingInfo Inviter:(NSString*)inviterEmail Invitee:(NSArray<NSString*>*)inviteeEmails WithComplete:(SocketIOComplete)complete;

+ (void)addNotificationType:(VLNotificationType)type Observer:(nonnull id)observer Selector:(nonnull SEL)selector;
+ (void)removeNotificationType:(VLNotificationType)type Observer:(nonnull id)observer;

+ (void)registerTerminallOnlineWithComplete:(SocketIOComplete)complete;
+ (void)registerTerminallOfflineWithComplete:(SocketIOComplete)complete;
+ (void)registerTerminallInMeetingWithComplete:(SocketIOComplete)complete;

@end

NS_ASSUME_NONNULL_END
