//
//  VLInfo.m
//  VLinkAMeeting
//
//  Created by lxf on 2019/1/18.
//  Copyright © 2019 cn. All rights reserved.
//

#import "VLInfo.h"

@implementation TerminalInfo
-(instancetype) initWithInformation:(NSDictionary*)information
{
    if(self=[super init])
    {
        self.terminalId = [information objectForKey:@"terminalId"];
        self.controlId = [information objectForKey:@"controlId"];
        self.displayName = [information objectForKey:@"displayName"];
        self.terminalType = [[information objectForKey:@"terminal"] integerValue];
        self.terminalStatus = [[information objectForKey:@"status"] integerValue];
        self.email = [information objectForKey:@"email"];
        self.pmi = [[information objectForKey:@"pmi"] integerValue];
        self.isInMeeting = [[information objectForKey:@"isInMeeting"] boolValue];
        self.currentMeetingId = [[information objectForKey:@"currentMeetingId"] integerValue];
    }
    return self;
}

- (NSDictionary*)serialization
{
    return @{@"terminalId": self.terminalId,
             @"controlId": self.controlId,
             @"displayName": self.displayName,
             @"terminal": @(self.terminalType),
             @"status": @(self.terminalStatus),
             @"email": self.email,
             @"pmi": @(self.pmi),
             @"isInMeeting": @(self.isInMeeting),
             @"currentMeetingId": @(self.currentMeetingId)
             };
}

@end



@implementation MeetingInfo
-(instancetype) initWithInformation:(NSDictionary*)information
{
    if(self=[super init])
    {
        self.meetingId = [[information objectForKey:@"meetingId"] integerValue];
        self.topic = [information objectForKey:@"topic"];
        self.isLocked = [[information objectForKey:@"isLocked"] boolValue];
        self.meetingType = [[information objectForKey:@"status"] integerValue];
    }
    return self;
}

- (NSDictionary*)serialization
{
    return @{@"meetingId": @(self.meetingId),
             @"topic": self.topic,
             @"isLocked": @(self.isLocked),
             @"status": @(self.meetingType)
             };
}
@end


@implementation InvitationInfo
-(instancetype) initWithInformation:(NSDictionary*)information
{
    if(self=[super init])
    {
        self.inviterName = [information objectForKey:@"inviterName"];    // 主持人名称
        self.inviterEmail = [information objectForKey:@"inviterEmail"];  // 主持人邮箱
        self.invitedTime = [[information objectForKey:@"invitedTime"] integerValue];  // 邀请的时间
        self.meetingId = [[information objectForKey:@"meetingId"] integerValue];   // 会议ID
        self.meetingTopic = [information objectForKey:@"meetingTopic"];    // 会议主题
        self.meetingEnded = [[information objectForKey:@"meetingEnded"] boolValue];  // 会议是否结束
    }
    return self;
}
@end
