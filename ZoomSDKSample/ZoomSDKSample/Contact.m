//
//  Personal.m
//  VLinkAMeeting
//
//  Created by lxf on 2019/1/15.
//  Copyright © 2019 cn. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

-(instancetype) initWithInformation:(NSDictionary*)information
{
    if(self=[super init])
    {
        self.userId = [[information objectForKey:@"id"] integerValue];
        self.userName = [information objectForKey:@"username"];
        self.userEmail = [information objectForKey:@"email"];
        self.reference = [information objectForKey:@"reference"];
        self.status = [[information objectForKey:@"status"] isEqualToString:@"On"] ? VLContactStatusOnline:VLContactStatusOffline;
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
        self.contacts = [cts copy];
    }
    
    return self;
}

@end
