//
//  MyOutlineView.m
//  ZoomSDKSample
//
//  Created by Yongquan Rao on 2019/4/24.
//  Copyright © 2019 TOTTI. All rights reserved.
//

#import "MyTableCellView.h"
#import "ZMSDKCommonHelper.h"

@implementation MyTableCellView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    NSTrackingArea * trackingArea = [[NSTrackingArea alloc] initWithRect:dirtyRect
                                                     options:NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved |
                         NSTrackingCursorUpdate |
                         NSTrackingActiveWhenFirstResponder |
                         NSTrackingActiveInKeyWindow |
                         NSTrackingActiveInActiveApp |
                         NSTrackingActiveAlways |
                         NSTrackingAssumeInside |
                         NSTrackingInVisibleRect |
                         NSTrackingEnabledDuringMouseDrag
                                                       owner:self
                                                    userInfo:nil];
    
    [self addTrackingArea: trackingArea];
    [self becomeFirstResponder];
    
    //
    
}

- (void) updateUI: (UserInfo*) userInfo
{
    if (_userInfo == nil)
    {
        _userInfo = userInfo;
    }

    
    if (_userInfo.status == USERSTATUS_OFFLINE) {
        [self.inviteButton setHidden:YES];
        [self.textOffline setHidden:NO];
        [self.textOnline setHidden:YES];
        self.btnTestImage.image = [NSImage imageNamed:@"offline"]; // delete and onlinestatus
    } else if (_userInfo.status == USERSTATUS_INMEETING) {

    } else { // online
        [self.inviteButton setHidden:YES];
        [self.textOffline setHidden:YES];
        [self.textOnline setHidden:NO];
        self.btnTestImage.image = [NSImage imageNamed:@"online"]; // delete and onlinestatus
    }
}

- (void)mouseEntered:(NSEvent*)theEvent
{
    NSLog(@"Enter........");
    
    if (_userInfo.status == USERSTATUS_OFFLINE) {
        self.inviteButton.image = [NSImage imageNamed:@"inviteoffline"];
        [self.inviteButton setHidden:NO];
        [self.textOffline setHidden:YES];
        [self.textOnline setHidden:YES];
        self.btnTestImage.image = [NSImage imageNamed:@"deleteoffline"]; // delete and onlinestatus
    } else if (_userInfo.status == USERSTATUS_INMEETING) {
        
    } else { // online
        self.inviteButton.image = [NSImage imageNamed:@"inviteonline"];
        [self.inviteButton setHidden:NO];
        [self.textOffline setHidden:YES];
        [self.textOnline setHidden:YES];
        self.btnTestImage.image = [NSImage imageNamed:@"deleteonline"]; // delete and onlinestatus
    }

    [[ZMSDKCommonHelper sharedInstance].myController mouseEntered:theEvent];
}

- (void)mouseExited:(NSEvent *)theEvent
{
    NSLog(@"Exit........");

    if (_userInfo.status == USERSTATUS_OFFLINE) {
        [self.inviteButton setHidden:YES];
        [self.textOffline setHidden:NO];
        [self.textOnline setHidden:YES];
        self.btnTestImage.image = [NSImage imageNamed:@"offline"]; // delete and onlinestatus
    } else if (_userInfo.status == USERSTATUS_INMEETING) {
        
    } else { // online
        [self.inviteButton setHidden:YES];
        [self.textOffline setHidden:YES];
        [self.textOnline setHidden:NO];
        self.btnTestImage.image = [NSImage imageNamed:@"online"]; // delete and onlinestatus
    }
    
    [[ZMSDKCommonHelper sharedInstance].myController mouseExited:theEvent];
}

- (IBAction)onTestImageButtonClicked:(id)sender {
    NSLog(@"8888888888888");
}
@end
