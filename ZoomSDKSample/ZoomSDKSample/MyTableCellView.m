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

- (IBAction)deleteButtonClicked:(id)sender {
    [[ZMSDKCommonHelper sharedInstance].myController deleteCell:_userInfo];
}

- (IBAction)inviteButtonClicked:(id)sender {
    [[ZMSDKCommonHelper sharedInstance].myController inviteCell:_userInfo];
}

- (void) updateUI: (UserInfo*) userInfo
{
    _userInfo = userInfo;
    
    if (_userInfo.status == USERSTATUS_OFFLINE) {
        [self.inviteButton setHidden:YES];
        [self.textOffline setHidden:NO];
        [self.textOnline setHidden:YES];
        self.deleteButton.image = [NSImage imageNamed:@"offline"]; // delete and onlinestatus
    } else if (_userInfo.status == USERSTATUS_INMEETING) {
        [self.inviteButton setHidden:YES];
        [self.textOffline setHidden:YES];
        [self.textOnline setHidden:NO];
        self.deleteButton.image = [NSImage imageNamed:@"online"]; // delete and onlinestatus
    } else { // online
        [self.inviteButton setHidden:YES];
        [self.textOffline setHidden:YES];
        [self.textOnline setHidden:NO];
        self.deleteButton.image = [NSImage imageNamed:@"online"]; // delete and onlinestatus
    }
}

- (void)mouseEntered:(NSEvent*)theEvent
{
    if (_userInfo.status == USERSTATUS_OFFLINE) {
        self.inviteButton.image = [NSImage imageNamed:@"inviteoffline"];
        [self.inviteButton setHidden:NO];
        [self.textOffline setHidden:YES];
        [self.textOnline setHidden:YES];
        self.deleteButton.image = [NSImage imageNamed:@"deleteoffline"]; // delete and onlinestatus
    } else if (_userInfo.status == USERSTATUS_INMEETING) {
        [self.inviteButton setHidden:NO];
        [self.textOffline setHidden:YES];
        [self.textOnline setHidden:YES];
        self.deleteButton.image = [NSImage imageNamed:@"deleteonline"]; // delete and onlinestatus
    } else { // online
        self.inviteButton.image = [NSImage imageNamed:@"inviteonline"];
        [self.inviteButton setHidden:NO];
        [self.textOffline setHidden:YES];
        [self.textOnline setHidden:YES];
        self.deleteButton.image = [NSImage imageNamed:@"deleteonline"]; // delete and onlinestatus
    }
}

- (void)mouseExited:(NSEvent *)theEvent
{
    if (_userInfo.status == USERSTATUS_OFFLINE) {
        [self.inviteButton setHidden:YES];
        [self.textOffline setHidden:NO];
        [self.textOnline setHidden:YES];
        self.deleteButton.image = [NSImage imageNamed:@"offline"]; // delete and onlinestatus
    } else if (_userInfo.status == USERSTATUS_INMEETING) {
        [self.inviteButton setHidden:YES];
        [self.textOffline setHidden:YES];
        [self.textOnline setHidden:NO];
        self.deleteButton.image = [NSImage imageNamed:@"online"]; // delete and onlinestatus
    } else { // online
        [self.inviteButton setHidden:YES];
        [self.textOffline setHidden:YES];
        [self.textOnline setHidden:NO];
        self.deleteButton.image = [NSImage imageNamed:@"online"]; // delete and onlinestatus
    }
}
@end
