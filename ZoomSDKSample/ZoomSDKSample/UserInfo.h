//
//  Personal.h
//  VLinkAMeeting
//
//  Created by lxf on 2019/1/15.
//  Copyright © 2019 cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLinkACommon.h"

NS_ASSUME_NONNULL_BEGIN
//UIKIT_EXTERN NSNotificationName const NSStringSocketIOLoginResultNotification;

@interface UserInfo : NSObject

@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, assign) unsigned long long userMeetingID;
@property (nonatomic, assign) unsigned long long currentMeetingId;
@property (nonatomic, strong) NSString *initial;         // 用户名首字母(大写)
@property (nonatomic, strong) NSString *reference;
@property (nonatomic, assign) VLUserStatus status;

-(instancetype) initWithInformation:(NSDictionary*)information;

@end

@interface Group : NSObject

@property (nonatomic, assign) NSInteger groupId;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *reference;
@property (nonatomic, strong) NSMutableArray<UserInfo*> *contacts;

-(instancetype) initWithInformation:(NSDictionary*)information;

@end

@interface VLUser : UserInfo

+ (VLUser *)shareVLUser;

- (void)updateUserInformation:(UserInfo*)information;
- (void)clearUserInformation;

@end

NS_ASSUME_NONNULL_END
