//
//  VLNetworkRequest.h
//  VLinkAMeeting
//
//  Created by lxf on 2019/1/15.
//  Copyright © 2018年 lxf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

#define USERLIST          @"/api/imUsers/%@/contacts"           // 新增通讯录联系人、获取通讯录联系人
#define DELUSER           @"/api/imUsers/%@/contacts/%@"        // 删除通讯录联系人
#define GROUPLIST         @"/api/imUsers/%@/groups"             // 新增通讯录分组、获取通讯录分组
#define INVITATIONSLIST   @"/api/imUsers/%@/invitations"        // 获取用户的最近十条被邀请记录(离线状态)
#define GROUPMODIFY       @"/api/imGroups/%@"                   // 更新通讯录分组、删除通讯录分组
#define GROUPDELETEUSER   @"/api/imGroups/%@/contacts/%@"       // 通讯录分组移除联系人


typedef void (^RequestSuccess)(id jsonData, BOOL state);

typedef void (^RequestFailure)(NSError *error);

@interface VLNetworkRequest : NSObject

+ (AFHTTPSessionManager *)shareManager;

//GET请求
+ (void)getWithURL:(NSString *)url parameters:(NSDictionary*) params success:(RequestSuccess)success failure:(RequestFailure)failure;

//POST请求
+ (void)postWithURL:(NSString *)url parameters:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;

//DELETE请求
+ (void)deleteWithURL:(NSString *)url parameters:(NSDictionary*) params success:(RequestSuccess)success failure:(RequestFailure)failure;

//PATCH请求
+ (void)patchWithURL:(NSString *)url parameters:(NSDictionary*) params success:(RequestSuccess)success failure:(RequestFailure)failure;

@end
