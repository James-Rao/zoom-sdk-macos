//
//  ZMSDKMutipleDelegate.m
//  ZoomSDKSample
//
//  Created by derain on 2018/11/22.
//  Copyright © 2018年 zoom.us. All rights reserved.
//

#import "ZMSDKDelegateMgr.h"

@import SocketIO;

@interface ZMSDKDelegateMgr()
{
    ZoomSDKAuthService* _authService;
}
@end

@implementation ZMSDKDelegateMgr
@synthesize authDelegateArray = _authDelegateArray;

static ZMSDKDelegateMgr* delegateMgr = nil;
- (id)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        delegateMgr = [super init];
        if(delegateMgr)
        {
            _authService = [[ZoomSDK sharedSDK] getAuthService];
            _authService.delegate = self;
            _authDelegateArray = [[NSMutableArray alloc] init];
        }
    });
    return delegateMgr;
}
-(void)cleanUp
{
    if(_authDelegateArray)
    {
        [_authDelegateArray removeAllObjects];
        [_authDelegateArray release];
        _authDelegateArray = nil;
    }
}
- (void)dealloc
{
    [self cleanUp];
    [super dealloc];
}

- (void)addAuthDelegateListener:(id<ZoomSDKAuthDelegate>)authDelegate
{
    [_authDelegateArray addObject:authDelegate];
}
- (void)removeAuthDelegateListener:(id<ZoomSDKAuthDelegate>)authDelegate
{
    [_authDelegateArray removeObject:authDelegate];
}

/**********ZoomSDKAuthDelegate***********/
- (void)onZoomSDKLogin:(ZoomSDKLoginStatus)loginStatus failReason:(NSString*)reason
{
    if(!_authDelegateArray)
        return;
    for (id target in _authDelegateArray)
    {
        if ([target respondsToSelector:@selector(onZoomSDKLogin: failReason:)])
        {
            [target onZoomSDKLogin:loginStatus failReason:reason];
        }
    }
}

- (void)onZoomSDKLogout
{
    if(!_authDelegateArray)
        return;
    for (id target in _authDelegateArray)
    {
        if ([target respondsToSelector:@selector(onZoomSDKLogout)])
        {
            [target onZoomSDKLogout];
        }
    }
}

- (void)onZoomIdentityExpired
{
    if(!_authDelegateArray)
        return;
    for (id target in _authDelegateArray)
    {
        if ([target respondsToSelector:@selector(onZoomIdentityExpired)])
        {
            [target onZoomIdentityExpired];
        }
    }
}

- (void)onZoomSDKAuthReturn:(ZoomSDKAuthError)returnValue
{
    if(!_authDelegateArray)
        return;
    for (id target in _authDelegateArray)
    {
        if ([target respondsToSelector:@selector(onZoomSDKAuthReturn:)])
        {
            [target onZoomSDKAuthReturn:returnValue];
        }
    }
}

///// new func
- (void) socketConnectHost
{
    NSURL* url = [[NSURL alloc] initWithString:@"http://218.17.76.147:9091"];
    SocketManager* manager = [[SocketManager alloc] initWithSocketURL:url config:@{@"log": @YES, @"compress": @YES}];
    SocketIOClient* socket = manager.defaultSocket;
    
    [socket on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected11111111111111111111");
    }];
    
    [socket connect];
}

@end
