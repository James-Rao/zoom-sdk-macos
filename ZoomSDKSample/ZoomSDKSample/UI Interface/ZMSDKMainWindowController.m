//
//  ZMSDKMainWindowController.m
//  ZoomSDKSample
//
//  Created by derain on 2018/11/16.
//  Copyright © 2018年 zoom.us. All rights reserved.
//

#import "ZMSDKMainWindowController.h"
#import "ZMSDKLoginWindowController.h"
#import "NSColor+Category.h"
#import "ZMSDKCommonHelper.h"
#import "ZMSDKJoinMeetingWindowController.h"
#import "ZMSDKEmailMeetingInterface.h"
#import "ZMSDKSSOMeetingInterface.h"
#import "ZMSDKApiMeetingInterface.h"
#import "ZMSDKMeetingStatusMgr.h"
#import "VLSocketIO.h"
#import "UserInfo.h"
#import "VLinfo.h"
#import "VLNetworkRequest.h"

@implementation ZMSDKAPIUserInfo: NSObject
@synthesize userID = _userID;
@synthesize zak = _zak;
@synthesize userToken = _userToken;

- (id)initWithUserID:(NSString*)userID zak:(NSString*)zak userToken:(NSString*)userToken
{
    self = [super init];
    if(self)
    {
        _userID = userID;
        _zak = zak;
        _userToken = userToken;
        return self;
    }
    return nil;
}
- (void)cleanUp
{
    _userID = nil;
    _zak = nil;
    _userToken = nil;
}
-(void)dealloc
{
    [self cleanUp];
    [super dealloc];
}

@end

@interface ZMSDKMainWindowController ()

@end

@implementation ZMSDKMainWindowController
@synthesize emailMeetingInterface = _emailMeetingInterface;
@synthesize ssoMeetingInterface = _ssoMeetingInterface;
@synthesize apiMeetingInterface = _apiMeetingInterface;
@synthesize joinMeetingWindowController = _joinMeetingWindowController;
@synthesize settingWindowController = _settingWindowController;
@synthesize scheduleWindowController = _scheduleWindowController;
@synthesize apiUserInfo = _apiUserInfo;
@synthesize meetingStatusMgr = _meetingStatusMgr;
@synthesize loginWindowController = _loginWindowController;
@synthesize isContactAdded = _isContactAdded;
@synthesize contactEmail = _contactEmail;
@synthesize contactsCount = _contactsCount;

- (id)init
{
    self = [super initWithWindowNibName:@"ZMSDKMainWindowController" owner:self];
    if(self)
    {
        _emailMeetingInterface = [[ZMSDKEmailMeetingInterface alloc] init];
        _ssoMeetingInterface = [[ZMSDKSSOMeetingInterface alloc] init];
        _apiMeetingInterface = [[ZMSDKApiMeetingInterface alloc] initWithWindowController:self];
        _joinMeetingWindowController = [[ZMSDKJoinMeetingWindowController alloc] initWithMgr:self];
        _settingWindowController = [[ZMSDKSettingWindowController alloc] init];
        _scheduleWindowController = [[ZoomSDKScheduleWindowCtr alloc] initWithUniqueID:0];
        _meetingStatusMgr = [[ZMSDKMeetingStatusMgr alloc] initWithWindowController:self];
        
        _contactsCount = -1;

        return self;
    }
    return nil;
}
- (void)cleanUp
{
    if (_scheduleWindowController) {
        [_scheduleWindowController release];
        _scheduleWindowController = nil;
    }
    if(_settingWindowController)
    {
        [_settingWindowController release];
        _settingWindowController = nil;
    }
    if(_emailMeetingInterface)
    {
        [_emailMeetingInterface release];
        _emailMeetingInterface = nil;
    }
    if(_ssoMeetingInterface)
    {
        [_ssoMeetingInterface release];
        _ssoMeetingInterface = nil;
    }
    if(_apiMeetingInterface)
    {
        [_apiMeetingInterface release];
        _apiMeetingInterface = nil;
    }
    if(_apiUserInfo)
    {
        [_apiUserInfo release];
        _apiUserInfo = nil;
    }
    if(_meetingStatusMgr)
    {
        [_meetingStatusMgr release];
        _meetingStatusMgr = nil;
    }
    if(_joinMeetingWindowController)
    {
        [_joinMeetingWindowController release];
        _joinMeetingWindowController = nil;
    }
    [_startVideoMeetingButton  setAction:nil];
    [_startVideoMeetingButton  setTarget:nil];
    [_startAudioMeetingButton  setAction:nil];
    [_startAudioMeetingButton  setTarget:nil];
    [_joinMeetingButton  setAction:nil];
    [_joinMeetingButton  setTarget:nil];
    [_scheduleMeetingButton  setAction:nil];
    [_scheduleMeetingButton  setTarget:nil];
    [_settingButton  setAction:nil];
    [_settingButton  setTarget:nil];
    [self close];
}
-(void)dealloc
{
    [self cleanUp];
    [super dealloc];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    //[self.window setLevel:NSPopUpMenuWindowLevel];
    [self updateUI];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    [[VLSocketIO shareManager] setDelegate:self];
    [[VLSocketIO shareManager] connectTimeout:10 WithHandler:^{
        NSLog(@"Cannot connect to server000000000000000000000");
    }];
}
- (void)updateUI
{
    if([ZMSDKCommonHelper sharedInstance].hasLogin)
    {
        [_startVideoMeetingButton setEnabled:YES];
        [_startAudioMeetingButton setEnabled:YES];
        [_joinMeetingButton setEnabled:YES];
        [_settingButton setEnabled:YES];
        if([ZMSDKCommonHelper sharedInstance].loginType == ZMSDKLoginType_API)
            [_scheduleMeetingButton setEnabled:NO];
        else
            [_scheduleMeetingButton setEnabled:YES];
    }
    else
    {
        [_startVideoMeetingButton setEnabled:NO];
        [_startAudioMeetingButton setEnabled:NO];
        [_joinMeetingButton setEnabled:YES];
        [_settingButton setEnabled:YES];
        [_scheduleMeetingButton setEnabled:NO];
    }
    
//    ZoomSDKAccountInfo* accountInfo = [[[ZoomSDK sharedSDK] getAuthService] getAccountInfo];
//    [VLUser shareVLUser].userName = [accountInfo getDisplayName];
//    [VLSocketIO registerTerminallOnlineWithComplete:^{
//        NSLog(@"TERMINALSTATUS_ONLINE33333333333333");
//    }];
}
- (void)awakeFromNib
{
    [self.window setBackgroundColor:[NSColor colorWithDeviceRed:249.0f/255 green:249.0f/255 blue:249.0f/255 alpha:1.0f]];
    
    [_startVideoMeetingButton setBordered:NO];
    [_startAudioMeetingButton setBordered:NO];
    [_joinMeetingButton setBordered:NO];
    [_scheduleMeetingButton setBordered:NO];
    [_settingButton setBordered:NO];
    
    [self setColor4ZMSDKPTImageButton:_startVideoMeetingButton colorType:ZMSDKPTImageButton_orange];
    [self changeHangoutButtonToStart];
    
    [_startAudioMeetingButton setNormalImage:[NSImage imageNamed:@"btn_startshare_normal"]];
    [_startAudioMeetingButton setHighlightImage:[NSImage imageNamed:@"btn_startshare_normal"]];
    [_startAudioMeetingButton setDisabledImage:[NSImage imageNamed:@"btn_startshare_normal"]];
    [_startAudioMeetingButton setTitle:@"Audio Meeting"];
    [self setColor4ZMSDKPTImageButton:_startAudioMeetingButton colorType:ZMSDKPTImageButton_orange];
    
    [_joinMeetingButton setNormalImage:[NSImage imageNamed:@"btn_joinmeeting_normal"]];
    [_joinMeetingButton setHighlightImage:[NSImage imageNamed:@"btn_joinmeeting_normal"]];
    [_joinMeetingButton setDisabledImage:[NSImage imageNamed:@"btn_joinmeeting_normal"]];
    [_joinMeetingButton setTitle:@"Join"];
    [self setColor4ZMSDKPTImageButton:_joinMeetingButton colorType:ZMSDKPTImageButton_blue];
    
    [_scheduleMeetingButton setNormalImage:[NSImage imageNamed:@"btn_schedule_normal"]];
    [_scheduleMeetingButton setHighlightImage:[NSImage imageNamed:@"btn_schedule_normal"]];
    [_scheduleMeetingButton setDisabledImage:[NSImage imageNamed:@"btn_schedule_normal"]];
    [_scheduleMeetingButton setTitle:@"Schedule"];
    [self setColor4ZMSDKPTImageButton:_scheduleMeetingButton colorType:ZMSDKPTImageButton_blue];
    
    
    [_settingButton setNormalImage:[NSImage imageNamed:@"btn_setting_normal"]];
    [_settingButton setHighlightImage:[NSImage imageNamed:@"btn_setting_normal"]];
    [_settingButton setDisabledImage:[NSImage imageNamed:@"btn_setting_normal"]];
    [_settingButton setTitle:@"Settings"];
     [self setColor4ZMSDKPTImageButton:_settingButton colorType:ZMSDKPTImageButton_blue];
    
    [self changeHangoutButtonToStart];
    //[self updateHangoutButtonByStatus:[[[ZPLoader sharedInstance] confStatus] conferenceStatus] ];
    //[self updateScheduleButton];
    
}
- (void)setColor4ZMSDKPTImageButton:(ZMSDKPTImageButton*)button colorType:(int)color
{
    switch (color) {
        case ZMSDKPTImageButton_orange://orange
            button.normalStartColor = [NSColor colorWithRGBString:@"FCA83E"];
            button.normalEndColor = [NSColor colorWithRGBString:@"FF8F00"];
            button.hoverStartColor = [NSColor colorWithRGBString:@"FCA83E"];
            button.hoverEndColor = [NSColor colorWithRGBString:@"FCA83E"];
            button.pressedStartColor = [NSColor colorWithRGBString:@"F38A03"];
            button.pressedEndColor = [NSColor colorWithRGBString:@"F38A03"];
            button.disabledStartColor = [NSColor colorWithRGBString:@"E3E3ED"];
            button.disabledEndColor = [NSColor colorWithRGBString:@"D9D9E3"];
            button.angle = 0.0;
            break;
        case ZMSDKPTImageButton_blue://blue
            button.normalStartColor = [NSColor colorWithRGBString:@"2DB9FF"];
            button.normalEndColor = [NSColor colorWithRGBString:@"2DA5FF"];
            button.hoverStartColor = [NSColor colorWithRGBString:@"2DB9FF"];
            button.hoverEndColor = [NSColor colorWithRGBString:@"2DB9FF"];
            button.pressedStartColor = [NSColor colorWithRGBString:@"26A0ED"];
            button.pressedEndColor = [NSColor colorWithRGBString:@"26A0ED"];
            button.disabledStartColor = [NSColor colorWithRGBString:@"E3E3ED"];
            button.disabledEndColor = [NSColor colorWithRGBString:@"D9D9E3"];
            button.angle = 0.0;
            break;
        case ZMSDKPTImageButton_red://red
            button.normalStartColor = [NSColor colorWithRGBString:@"EB5A5A"];
            button.normalEndColor = [NSColor colorWithRGBString:@"F56464"];
            button.hoverStartColor = [NSColor colorWithRGBString:@"F56464"];
            button.hoverEndColor = [NSColor colorWithRGBString:@"F56464"];
            button.pressedStartColor = [NSColor colorWithRGBString:@"EB5A5A"];
            button.pressedEndColor = [NSColor colorWithRGBString:@"EB5A5A"];
            button.disabledStartColor = [NSColor colorWithRGBString:@"E3E3ED"];
            button.disabledEndColor = [NSColor colorWithRGBString:@"D9D9E3"];
            button.angle = 0.0;
            break;
            
        default:
            break;
    }
}

- (void)updateScheduleButton
{
    if ([ZMSDKCommonHelper sharedInstance].hasLogin && [ZMSDKCommonHelper sharedInstance].loginType != ZMSDKLoginType_API) {
        [_scheduleMeetingButton setEnabled:YES];
    } else {
        [_scheduleMeetingButton setEnabled:NO];
    }
}

- (void)changeHangoutButtonToStart
{
    [_startVideoMeetingButton setTitle:@"Video Meeting"];
    [_startVideoMeetingButton setNormalImage:[NSImage imageNamed:@"btn_startvideo_normal"]];
    [_startVideoMeetingButton setHighlightImage:[NSImage imageNamed:@"btn_startvideo_normal"]];
    [_startVideoMeetingButton setDisabledImage:[NSImage imageNamed:@"btn_startvideo_normal"]];
}

- (IBAction)onStartVideoMeetingButtonClicked:(id)sender
{
    if([ZMSDKCommonHelper sharedInstance].loginType == ZMSDKLoginType_Email && [ZMSDKCommonHelper sharedInstance].hasLogin)
    {
        [_emailMeetingInterface startVideoMeetingForEmailUser];
    }
    if([ZMSDKCommonHelper sharedInstance].loginType == ZMSDKLoginType_SSO && [ZMSDKCommonHelper sharedInstance].hasLogin)
    {
        [_ssoMeetingInterface startVideoMeetingForSSOUser];
    }
    if([ZMSDKCommonHelper sharedInstance].loginType == ZMSDKLoginType_API && [ZMSDKCommonHelper sharedInstance].hasLogin)
    {
        [_apiMeetingInterface startVideoMeetingForApiUser];
    }
}
- (IBAction)onStartAudioMeetingButtonClicked:(id)sender
{
    if([ZMSDKCommonHelper sharedInstance].loginType == ZMSDKLoginType_Email && [ZMSDKCommonHelper sharedInstance].hasLogin)
    {
        [_emailMeetingInterface startAudioMeetingForEmailUser];
    }
    if([ZMSDKCommonHelper sharedInstance].loginType == ZMSDKLoginType_SSO && [ZMSDKCommonHelper sharedInstance].hasLogin)
    {
        [_ssoMeetingInterface startAudioMeetingForSSOUser];
    }
    if([ZMSDKCommonHelper sharedInstance].loginType == ZMSDKLoginType_API && [ZMSDKCommonHelper sharedInstance].hasLogin)
    {
        [_apiMeetingInterface startAudioMeetingForApiUser];
    }
}

- (IBAction)onJoinMeetingButtonClicked:(id)sender
{
    [_joinMeetingWindowController showSelf];
}
- (IBAction)onScheduleButtonClicked:(id)sender
{
    if([[ZMSDKCommonHelper sharedInstance] isUseCutomizeUI])
    {
        [_scheduleWindowController.window makeKeyAndOrderFront:nil];
        [_scheduleWindowController showWindow:nil];
    }
    else
    {
        ZoomSDKPremeetingService* premeetingService = [[ZoomSDK sharedSDK] getPremeetingService];
        NSWindow* scheduleWindow = [[[NSWindow alloc] init] autorelease];
        ZoomSDKError error = ZoomSDKError_UnKnow;
        error = [premeetingService showScheduleEditMeetingWindow:YES Window:&scheduleWindow MeetingID:0];
        if(ZoomSDKError_Success == error)
            [scheduleWindow center];
    }
}
- (IBAction)onSettingButtonClicked:(id)sender
{
    if([[ZMSDKCommonHelper sharedInstance] isUseCutomizeUI])
    {
        [_settingWindowController.window makeKeyAndOrderFront:nil];
        [_settingWindowController showWindow:nil];
    }
    else
    {
        ZoomSDKSettingService* setting = [[ZoomSDK sharedSDK] getSettingService];
        [[setting getGeneralSetting] hideSettingComponent:SettingComponent_AdvancedFeatureButton hide:YES];
        [[setting getGeneralSetting] hideSettingComponent:SettingComponent_AdvancedFeatureTab hide:YES];
        
        ZoomSDKMeetingService* meetingService = [[ZoomSDK sharedSDK] getMeetingService];
        ZoomSDKMeetingUIController* controller = [meetingService getMeetingUIController];
        [controller showMeetingComponent:MeetingComponent_Setting window:nil show:YES InPanel:YES frame:NSZeroRect];
        [[setting getGeneralSetting] setCustomFeedbackURL:@"www.zoom.us"];
    }
}
- (void)updateMainWindowUIWithMeetingStatus:(ZoomSDKMeetingStatus)status
{
    if(!status)
        return;
    switch (status) {
        case ZoomSDKMeetingStatus_Connecting:
        {
            [_startVideoMeetingButton setEnabled:NO];
            [_startAudioMeetingButton setEnabled:NO];
            [_joinMeetingButton setEnabled:NO];
            if([ZMSDKCommonHelper sharedInstance].loginType == ZMSDKLoginType_API || ![ZMSDKCommonHelper sharedInstance].hasLogin)
                [_scheduleMeetingButton setEnabled:NO];
            else
                [_scheduleMeetingButton setEnabled:YES];
        }
            break;
        case ZoomSDKMeetingStatus_InMeeting:
        {
            [_startVideoMeetingButton setEnabled:NO];
            [_startAudioMeetingButton setEnabled:NO];
            [_joinMeetingButton setEnabled:NO];
            if([ZMSDKCommonHelper sharedInstance].loginType == ZMSDKLoginType_API || ![ZMSDKCommonHelper sharedInstance].hasLogin)
                [_scheduleMeetingButton setEnabled:NO];
            else
                [_scheduleMeetingButton setEnabled:YES];
        }
            break;
        case ZoomSDKMeetingStatus_Webinar_Promote:
        case ZoomSDKMeetingStatus_Webinar_Depromote:
        case ZoomSDKMeetingStatus_AudioReady:
            break;
        case ZoomSDKMeetingStatus_Failed:
        case ZoomSDKMeetingStatus_Ended:
        {
            if([ZMSDKCommonHelper sharedInstance].hasLogin)
            {
                [_startVideoMeetingButton setEnabled:YES];
                [_startAudioMeetingButton setEnabled:YES];
                if([ZMSDKCommonHelper sharedInstance].loginType == ZMSDKLoginType_API)
                    [_scheduleMeetingButton setEnabled:NO];
                else
                    [_scheduleMeetingButton setEnabled:YES];
                [_joinMeetingButton setEnabled:YES];
            }
            else
            {
                [_startVideoMeetingButton setEnabled:NO];
                [_startAudioMeetingButton setEnabled:NO];
                [_scheduleMeetingButton setEnabled:NO];
                [_joinMeetingButton setEnabled:YES];
            }
            [self changeHangoutButtonToStart];
        }
        default:
            break;
    }
}

- (void)initApiUserInfoWithID:(NSString*)userID zak:(NSString*)zak userToken:(NSString*)userToken
{
    _apiUserInfo = [[ZMSDKAPIUserInfo alloc] initWithUserID:userID zak:zak userToken:userToken];
}

#pragma mark - VLSocketIODelegate
- (void)OnConnect:(BOOL)success
{
    NSLog(@"Connect to server successfully!!!!!!!!!!!!!!!!!!");
//    ZoomSDKAccountInfo* accountInfo = [[[ZoomSDK sharedSDK] getAuthService] getAccountInfo];
//    [VLUser shareVLUser].userName = [accountInfo getDisplayName];
//    [VLSocketIO registerTerminallOnlineWithComplete:^{
//        NSLog(@"TERMINALSTATUS_ONLINE33333333333333");
//    }];
    
//    double delayInSeconds = 1.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [VLUser shareVLUser].userName = [accountInfo getDisplayName];
//        [VLSocketIO registerTerminallOnlineWithComplete:^{
//            NSLog(@"TERMINALSTATUS_ONLINE33333333333333");
//        }];
//    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ZoomSDKAccountInfo* accountInfo = [[[ZoomSDK sharedSDK] getAuthService] getAccountInfo];
        [VLUser shareVLUser].userName = [accountInfo getDisplayName];
        [VLSocketIO registerTerminallOnlineWithComplete:^{
            NSLog(@"TERMINALSTATUS_ONLINE33333333333333");
        }];
    });
}

- (void)UserLogin:(UserInfo *)UserInfo{
    NSLog(@"user login4444444444444444444444");
    [VLUser shareVLUser].userId = UserInfo.userId;
//    if ([VLUser shareVLUser].userId == 0) {
//        //请求用户离线邀请信息
//        DLog(@"load all offline invitations");
//        NSString *url = [NSString stringWithFormat:INVITATIONSLIST, @(UserInfo.userId)];
//        [VLNetworkRequest getWithURL:url parameters:nil success:^(id jsonData, BOOL state) {
//            if(state)
//            {
//                DLog(@"get all groups:[%lu]", (unsigned long)[jsonData count]);
//                for (NSDictionary *invitationItem in jsonData)
//                {
//                    InvitationInfo *item = [[InvitationInfo alloc] initWithInformation:invitationItem];
//                    [self.itemArray addObject:item];
//                }
//                if (self.itemArray.count > 0) {
//                    [self.meetingTableView reloadData];
//                }
//            }
//            else
//            {
//                DLog(@"%@", @"出错了");
//            }
//        } failure:^(NSError *error) {
//            DLog(@"%@", error.description);
//        }];
//    }
//
//    // 保存用户信息
//    [[VLUser shareVLUser] updateUserInformation:UserInfo];
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:NSStringSocketIOLoginResultNotification object:nil userInfo:@{@"returnValue":UserInfo}];
}

- (void)handleNotify:(NSNotification *)notify
{
//    if([notify.name isEqualToString:NotificationInvitedName])            // 邀请通知
//    {
//        InvitationInfo *invitationInfo = [notify.userInfo objectForKey:@"invitationInfo"];
//        [self.itemArray addObject:invitationInfo];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.meetingTableView reloadData];
//        });
//    }
//    else if([notify.name isEqualToString:NotificationStatusOtherLogin])  // 异地登录通知
//    {
//        [[[MobileRTC sharedRTC] getAuthService] logoutRTC];
//
//        UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"异地登录" message:@"你的账号在其他设备上登录成功,请确认是否本人登录" preferredStyle:UIAlertControllerStyleAlert];
//
//        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            LoginViewController* loginVC = [[LoginViewController alloc]init];
//            UINavigationController* navVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
//            [self presentViewController:navVC animated:YES completion:nil];
//        }]];
//
//        [self presentViewController:alertVC animated:YES completion:nil];
//    }
}
#pragma mark - Premeeting Delegate


// new functions
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    if (self.contactsCount == -1) {
        [self getContacts];
    }

    return self.contactsCount;
}

- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    return nil;
}

- (IBAction)onAddContactButtonClicked:(id)sender {
    AddContactWindowController* addContactWindowController = [[AddContactWindowController alloc] initWithWindowNibName:@"AddContactWindowController"];
    addContactWindowController.parent = self;
    [[NSApplication sharedApplication] runModalForWindow:addContactWindowController.window];
    if (_isContactAdded == YES) {
        NSLog(@"Add contact 999999999");

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *url = [NSString stringWithFormat:USERLIST, @([VLUser shareVLUser].userId)];
            NSDictionary *parames = @{@"email": IsStrEmpty(_contactEmail)?@" ":_contactEmail};
            [VLNetworkRequest postWithURL:url parameters:parames success:^(id jsonData, BOOL state) {
                if(state)
                {
                    NSLog(@"联系人添加成功");
                    [self getContacts];
                }
                else
                {
                    NSLog(@"联系人添加失败");
                }
            } failure:^(NSError *error) {
                NSLog(@"%@", error.description);
            }];
        });
    } else {
        NSLog(@"Cancel contact  99999999999");
    }
}

- (void) getContacts {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *url = [NSString stringWithFormat:USERLIST, @([VLUser shareVLUser].userId)];
        [VLNetworkRequest getWithURL:url parameters:nil success:^(id jsonData, BOOL state) {
            if(state)
            {
                DLog(@"get all contacts:[%lu]", (unsigned long)[jsonData count]);
                for (NSDictionary *userinfo in jsonData)
                {
                    UserInfo *info = [[UserInfo alloc] initWithInformation:userinfo];
                    NSLog(info.userName);
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.contactsCount = [jsonData count];
                    [self.contactTableView reloadData];
                });

            }
            else
            {
                DLog(@"%@", @"出错了");
            }
        } failure:^(NSError *error) {
            DLog(@"%@", error.description);
        }];
    });
}
@end
