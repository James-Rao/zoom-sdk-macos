//
//  JSONResponseSerializerWithData.m
//  VLinkAMeeting
//
//  Created by luxiaofei on 2019/1/24.
//  Copyright © 2019年 cn. All rights reserved.
//

#import "JSONResponseSerializerWithData.h"

static NSString * const JSONResponseSerializerWithDataKey = @"JSONResponseSerializerWithDataKey";

@implementation JSONResponseSerializerWithData

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    id JSONObject = [super responseObjectForResponse:response data:data error:error];
    if (*error != nil)
    {
        if([response isKindOfClass:[NSHTTPURLResponse class]] && ((NSHTTPURLResponse*)response).statusCode==400)
        {
            *error = nil;
            return (JSONObject);
        }
        else
        {
            NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
            if (data == nil)
            {
                userInfo[JSONResponseSerializerWithDataKey] = [NSData data];
            }
            else
            {
                userInfo[JSONResponseSerializerWithDataKey] = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
            NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
            (*error) = newError;
        }
        
    }
    
    return (JSONObject);
}

@end
