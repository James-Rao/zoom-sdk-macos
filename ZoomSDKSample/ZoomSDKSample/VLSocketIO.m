//
//  VLSocketIO.m
//  VLinkAMeeting
//
//  Created by lxf on 2019/1/18.
//  Copyright © 2019 cn. All rights reserved.
//

#import "VLSocketIO.h"
#import "UserInfo.h"
#import "VLInfo.h"

@interface VLSocketIO()

@property (nonatomic, strong) SocketManager* manager;
@property (nonatomic, strong) SocketIOClient* socket;
@property (nonatomic,   weak) id<VLSocketIODelegate> delegate;

@end

@implementation VLSocketIO

+ (VLSocketIO *)shareManager
{
    static VLSocketIO *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[VLSocketIO alloc] initWithAddress:@"http://120.79.202.176:9091"];
        
    });
    return manager;
}

- (void)setDelegate:(id<VLSocketIODelegate>)delegate
{
    _delegate = delegate;
}

- (instancetype)initWithAddress:(NSString*)address
{
    if(self=[super init])
    {
        NSURL* url = [[NSURL alloc] initWithString:address];
        _manager = [[SocketManager alloc] initWithSocketURL:url config:@{@"log": @NO, @"compress": @YES}];
        _socket = _manager.defaultSocket;
        
        VLWeakSelf(weakSelf);
        [self ListenOn:@"connect" WithCallback:^(NSArray * _Nonnull array, SocketAckEmitter * _Nonnull ackEmitter) {
            if([weakSelf.delegate respondsToSelector:@selector(OnConnect:)]){
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [weakSelf.delegate OnConnect:YES];
                });
            }
        }];
        [self ListenOn:@"user_login" WithCallback:^(NSArray * _Nonnull array, SocketAckEmitter * _Nonnull ackEmitter) {
            if([array count]>0 && [weakSelf.delegate respondsToSelector:@selector(UserLogin:)]){
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    UserInfo *userinfo = [[UserInfo alloc] initWithInformation:[array objectAtIndex:0]];
                    [weakSelf.delegate UserLogin:userinfo];
                });
            }
        }];
        [self ListenOn:@"invited_join_meeting" WithCallback:^(NSArray * _Nonnull array, SocketAckEmitter * _Nonnull ackEmitter) {
            if([array count] == 1)
            {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    InvitationInfo *invitationInfo = [[InvitationInfo alloc] initWithInformation:[array objectAtIndex:0]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationInvitedName
                                                                        object:self
                                                                      userInfo:@{@"invitationInfo":invitationInfo}];
                });
            }
        }];
        [self ListenOn:@"contact_status_changed" WithCallback:^(NSArray * _Nonnull array, SocketAckEmitter * _Nonnull ackEmitter) {
            if([array count] == 1)
            {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    UserInfo *userinfo = [[UserInfo alloc] initWithInformation:[array objectAtIndex:0]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationStatusUpdateName
                                                                        object:self
                                                                      userInfo:@{@"userinfo":userinfo}];
                });
            }
        }];
        [self ListenOn:@"other_terminal_connected" WithCallback:^(NSArray * _Nonnull array, SocketAckEmitter * _Nonnull ackEmitter) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationStatusOtherLogin
                                                                    object:self
                                                                  userInfo:nil];
            });
        }];
    }
    return self;
}

- (void)ListenOn:(NSString *)event WithCallback:(SocketIOCallback)callback
{
    if(_socket==nil || IsStrEmpty(event)) return;
    
    [self.socket on:event callback:callback];
}

- (void)connectTimeout:(double)timeoutAfter WithHandler:(SocketIOHandle)handler
{
    [self.socket connectWithTimeoutAfter:timeoutAfter withHandler:handler];
}

- (void)disconnect
{
    if(_socket!=nil && _socket.status==SocketIOStatusConnected)
    {
        [self.socket disconnect];
    }
}

- (void)terminalInfoUpdate:(TerminalInfo*)terminalInfo WithComplete:(SocketIOComplete)complete
{
    if(_socket==nil || _socket.status!=SocketIOStatusConnected) return;
    
    NSArray *array = @[[terminalInfo serialization]];
    //[self.socket emit:@"terminal_info_update" with:array completion:complete];
    [self.socket emit:@"terminal_info_update" with:array];
}

- (void)inviteContactsMeeting:(MeetingInfo*)meetingInfo Inviter:(NSString*)inviterEmail Invitee:(NSArray<NSString*>*)inviteeEmails WithComplete:(SocketIOComplete)complete
{
    if(_socket==nil || _socket.status!=SocketIOStatusConnected || IsStrEmpty(inviterEmail) || [inviteeEmails count]==0) return;
    
    NSArray *array = @[[meetingInfo serialization], inviterEmail, inviteeEmails];
    //[self.socket emit:@"invite_contacts_meeting" with:array completion:complete];
    [self.socket emit:@"invite_contacts_meeting" with:array];
}

+ (void)addNotificationType:(VLNotificationType)type Observer:(nonnull id)observer Selector:(nonnull SEL)selector
{
    NSString *notificationName;
    if(type==VLNotificationTypeInvited)
        notificationName = NotificationInvitedName;
    else if(type == VLNotificationTypeContactUpdate)
        notificationName = NotificationStatusUpdateName;
    else if(type == VLNotificationTypeOtherLogin)
        notificationName = NotificationStatusOtherLogin;
    else
        return;
    
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:notificationName object:nil];
}

+ (void)removeNotificationType:(VLNotificationType)type Observer:(nonnull id)observer
{
    NSString *notificationName;
    if(type==VLNotificationTypeInvited)
        notificationName = NotificationInvitedName;
    else if(type == VLNotificationTypeContactUpdate)
        notificationName = NotificationStatusUpdateName;
    else if(type == VLNotificationTypeOtherLogin)
        notificationName = NotificationStatusOtherLogin;
    else
        return;
    
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:notificationName object:nil];
}

+ (void)registerTerminallOnlineWithComplete:(SocketIOComplete)complete
{
    NSDictionary *info = @{@"terminalId": @"",
                           @"controlId": @"",
                           @"displayName": [VLUser shareVLUser].userName,
                           @"terminal": @(TERMINALTYPE_PC),
                           @"status": @(TERMINALSTATUS_ONLINE),
                           @"email": [VLUser shareVLUser].userEmail,
                           @"pmi": @([VLUser shareVLUser].userMeetingID),
                           @"currentMeetingId": @(0),
                           @"isInMeeting": @(FALSE),
                           };
    TerminalInfo *terminalInfo = [[TerminalInfo alloc] initWithInformation:info];
    
    [[VLSocketIO shareManager] terminalInfoUpdate:terminalInfo WithComplete:complete];
}

+ (void)registerTerminallOfflineWithComplete:(SocketIOComplete)complete
{
    NSDictionary *info = @{@"terminalId": @"",
                           @"controlId": @"",
                           @"displayName": [VLUser shareVLUser].userName,
                           @"terminal": @(TERMINALTYPE_MOBILE),
                           @"status": @(TERMINALSTATUS_OFFLINE),
                           @"email": [VLUser shareVLUser].userEmail,
                           @"pmi": @([VLUser shareVLUser].userMeetingID),
                           @"currentMeetingId": @(0),
                           };
    TerminalInfo *terminalInfo = [[TerminalInfo alloc] initWithInformation:info];
    [[VLSocketIO shareManager] terminalInfoUpdate:terminalInfo WithComplete:complete];
}

+ (void)registerTerminallInMeetingWithComplete:(SocketIOComplete)complete
{
    NSDictionary *info = @{@"terminalId": @"",
                           @"controlId": @"",
                           @"displayName": [VLUser shareVLUser].userName,
                           @"terminal": @(TERMINALTYPE_MOBILE),
                           @"status": @(TERMINALSTATUS_INMEETING),
                           @"email": [VLUser shareVLUser].userEmail,
                           @"pmi": @([VLUser shareVLUser].userMeetingID),
                           @"currentMeetingId": @([VLUser shareVLUser].currentMeetingId),
                           };
    
    TerminalInfo *terminalInfo = [[TerminalInfo alloc] initWithInformation:info];
    [[VLSocketIO shareManager] terminalInfoUpdate:terminalInfo WithComplete:complete];
}

@end
