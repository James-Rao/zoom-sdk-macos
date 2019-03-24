//
//  VLNetworkRequest.m
//  VLinkAMeeting
//
//  Created by lxf on 2019/1/15.
//  Copyright © 2018年 lxf. All rights reserved.
//

#import "VLNetworkRequest.h"
#import "JSONResponseSerializerWithData.h"

@interface VLNetworkManager : AFHTTPSessionManager
+(AFHTTPSessionManager *)shareManager;
@end

@implementation VLNetworkManager
+(AFHTTPSessionManager *)shareManager
{
    static AFHTTPSessionManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://218.17.76.147:9090"]];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 20.0f;
        manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndex:400];
        [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        //直接用AFN解析数据 解决服务端返回null的问题
        JSONResponseSerializerWithData *reponse = [JSONResponseSerializerWithData serializer];
        reponse.removesKeysWithNullValues = YES;
        manager.responseSerializer = reponse;
        
        [manager setTaskWillPerformHTTPRedirectionBlock:^NSURLRequest * _Nullable(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSURLResponse * _Nonnull response, NSURLRequest * _Nonnull request) {
            return nil;
        }];
        
    });
    return manager;
}
@end


@implementation VLNetworkRequest

+ (AFHTTPSessionManager *)shareManager
{
    static AFHTTPSessionManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [VLNetworkManager shareManager];
    });
    return manager;
}


//POST请求
+ (void)postWithURL:(NSString *)url parameters:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure
{
    AFHTTPSessionManager *manager = [VLNetworkRequest shareManager];
    NSURLSessionDataTask *task = [manager POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if([[responseObject objectForKey:@"code"] intValue] > 40000)
        {
            success(responseObject, NO);
        }
        else
        {
            success(responseObject, YES);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    //DLog(@"%@", [task class]);
}

//GET请求
+ (void)getWithURL:(NSString *)url parameters:(NSDictionary*) params success:(RequestSuccess)success failure:(RequestFailure)failure
{
    AFHTTPSessionManager *manager = [VLNetworkRequest shareManager];
    NSURLSessionDataTask *task = [manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject, YES);
//        if([(NSArray*)responseObject count] > 0)
//        {
//
//        }
//        else
//        {
//            success(@{@"message":@"暂无数据, 稍后再试"}, YES);
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        failure(error);
    }];
    
//    DLog(@"%@", [task class]);
}


//DELETE请求
+ (void)deleteWithURL:(NSString *)url parameters:(NSDictionary*) params success:(RequestSuccess)success failure:(RequestFailure)failure
{
    AFHTTPSessionManager *manager = [VLNetworkRequest shareManager];
    NSURLSessionDataTask *task = [manager DELETE:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject, responseObject==nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        failure(error);
    }];
    
//    DLog(@"%@", [task class]);
}

//PATCH请求
+ (void)patchWithURL:(NSString *)url parameters:(NSDictionary*) params success:(RequestSuccess)success failure:(RequestFailure)failure
{
    AFHTTPSessionManager *manager = [VLNetworkRequest shareManager];
    NSURLSessionDataTask *task = [manager PATCH:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject, [responseObject objectForKey:@"name"]!=nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        failure(error);
    }];
    
//    DLog(@"%@", [task class]);
}

@end
