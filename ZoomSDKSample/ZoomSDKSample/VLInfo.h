//
//  VLInfo.h
//  VLinkAMeeting
//
//  Created by lxf on 2019/1/18.
//  Copyright © 2019 cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLinkACommon.h"

NS_ASSUME_NONNULL_BEGIN


@interface TerminalInfo : NSObject

@property (nonatomic, strong) NSString *terminalId;
@property (nonatomic, strong) NSString *controlId;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) NSUInteger pmi;
@property (nonatomic, assign) BOOL isInMeeting;
@property (nonatomic, assign) NSUInteger currentMeetingId;
@property (nonatomic, assign) VLTerminalType terminalType;
@property (nonatomic, assign) VLTerminalStatus terminalStatus;

-(instancetype) initWithInformation:(NSDictionary*)information;

- (NSDictionary*)serialization;

@end

@interface MeetingInfo : NSObject

@property (nonatomic, strong) NSString *topic;
@property (nonatomic, assign) NSUInteger meetingId;
@property (nonatomic, assign) BOOL isLocked;
@property (nonatomic, assign) VLMeetingStatus meetingType;

-(instancetype) initWithInformation:(NSDictionary*)information;
- (NSDictionary*)serialization;

@end


@interface InvitationInfo : NSObject

@property (nonatomic, strong) NSString *inviterName;
@property (nonatomic, strong) NSString *inviterEmail;
@property (nonatomic, assign) NSUInteger invitedTime;
@property (nonatomic, assign) NSUInteger meetingId;
@property (nonatomic, strong) NSString *meetingTopic;
@property (nonatomic, assign) BOOL meetingEnded;

-(instancetype) initWithInformation:(NSDictionary*)information;

@end

NS_ASSUME_NONNULL_END
