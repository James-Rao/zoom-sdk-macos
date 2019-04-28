//
//  MyGroupTableCellView.m
//  ZoomSDKSample
//
//  Created by Yongquan Rao on 2019/4/27.
//  Copyright © 2019 TOTTI. All rights reserved.
//

#import "MyGroupTableCellView.h"
#import "ZMSDKCommonHelper.h"

@implementation MyGroupTableCellView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    
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

- (void) updateUI: (Group*) group
{
    _group = group;
    
    [self.inviteButton setHidden:YES];
    [self.deleteButton setHidden:YES];
    [self.editButton setHidden:YES];
    [self.groupmanageButton setHidden:YES];
}


- (void)mouseEntered:(NSEvent*)theEvent
{
    if  ([_group.groupName isEqualToString:@"所有人"]) {
        return;
    }
    
    [self.inviteButton setHidden:NO];
    [self.deleteButton setHidden:NO];
    [self.editButton setHidden:NO];
    [self.groupmanageButton setHidden:NO];
}

- (void)mouseExited:(NSEvent *)theEvent
{
    if  ([_group.groupName isEqualToString:@"所有人"]) {
        return;
    }
    
    [self.inviteButton setHidden:YES];
    [self.deleteButton setHidden:YES];
    [self.editButton setHidden:YES];
    [self.groupmanageButton setHidden:YES];
}

- (IBAction)onDeleteClicked:(id)sender {
    [[ZMSDKCommonHelper sharedInstance].myController deleteGroup:_group];
}

- (IBAction)onEditClicked:(id)sender {
    [[ZMSDKCommonHelper sharedInstance].myController editGroup:_group];
}

- (IBAction)onInviteClicked:(id)sender {
}

- (IBAction)onGroupmanageClicked:(id)sender {
    [[ZMSDKCommonHelper sharedInstance].myController manageGroup:_group];
}
@end
