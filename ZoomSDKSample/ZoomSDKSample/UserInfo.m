//
//  Personal.m
//  VLinkAMeeting
//
//  Created by lxf on 2019/1/15.
//  Copyright © 2019 cn. All rights reserved.
//

#import "UserInfo.h"
NSNotificationName const NSStringSocketIOLoginResultNotification = @"com.vlinka.meeting.socketio.loginResult";

@implementation UserInfo
- (instancetype)init{
    if (self = [super init]) {
        self.userId = 0;
        self.userName = @"";
        self.userEmail = @"";
        self.initial = @"";
        self.userMeetingID = 0;
        self.reference = @"";
        self.status = USERSTATUS_OFFLINE;
    }
    return self;
}
-(instancetype) initWithInformation:(NSDictionary*)information
{
    if(self=[super init])
    {
        self.userId = [[information objectForKey:@"id"] integerValue];
        self.userName = [information objectForKey:@"username"];
        self.userEmail = [information objectForKey:@"email"];
        self.initial = [information objectForKey:@"initial"];
        self.reference = [information objectForKey:@"reference"];
        NSString *curStatus = [information objectForKey:@"status"];
        self.status = [curStatus isEqualToString:@"OFFLINE"]?USERSTATUS_OFFLINE:[curStatus isEqualToString:@"MOBILE_ONLINE"]?USERSTATUS_MOBILE_ONLINE:[curStatus isEqualToString:@"INMEETING"]?USERSTATUS_INMEETING:[curStatus isEqualToString:@"PC_ONLINE"]?USERSTATUS_PC_ONLINE:[curStatus isEqualToString:@"STB_ONLINE"]?USERSTATUS_STB_ONLINE:USERSTATUS_MOBILE_ONLINE;
//        self.userMeetingID = 0;
    }
    
    return self;
}

@end


@implementation Group

-(instancetype) initWithInformation:(NSDictionary*)information
{
    if(self=[super init])
    {
        self.groupId = [[information objectForKey:@"id"] integerValue];
        self.groupName = [information objectForKey:@"name"];
        self.reference = [information objectForKey:@"reference"];
        NSMutableArray *cts = [[NSMutableArray alloc] init];
        for (NSDictionary *contact in [information objectForKey:@"contacts"])
            [cts addObject:[[UserInfo alloc] initWithInformation:contact]];
        self.contacts = cts;
    }
    
    return self;
}

@end

@implementation VLUser

+ (VLUser *)shareVLUser
{
    static VLUser *defaultUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        defaultUser = [[VLUser alloc] init];
        
    });
    return defaultUser;
}

-(instancetype) init{
    if(self=[super init]){
        self.userId = 0;
        self.userName = @"";
        self.userEmail = @"";
        self.initial = @"";
        self.userMeetingID = 0;
        self.reference = @"";
        self.status = USERSTATUS_OFFLINE;
    }
    return self;
}

-(void) updateUserInformation:(UserInfo*)information{
    self.userId = information.userId;
    self.userName = information.userName;
    self.userEmail = information.userEmail;
    self.initial = information.initial;
//    self.userMeetingID = information.userMeetingID;
    self.reference = information.reference;
    self.status = information.status;
}

- (void)clearUserInformation{
    self.userId = 0;
    self.userName = @"";
    self.userEmail = @"";
    self.initial = @"";
    self.userMeetingID = 0;
    self.reference = @"";
    self.status = USERSTATUS_OFFLINE;
}

@end
