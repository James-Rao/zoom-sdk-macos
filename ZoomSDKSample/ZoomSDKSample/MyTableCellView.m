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
    
    // Drawing code here.
}

- (void)awakeFromNib
{
    CGRect rect = self.bounds;
    NSTrackingArea *area =[[NSTrackingArea alloc] initWithRect:rect options:NSTrackingMouseEnteredAndExited|NSTrackingActiveInKeyWindow owner:self userInfo:nil];
    [self addTrackingArea:area];
}

- (void)mouseEntered:(NSEvent*)theEvent
{
    NSLog(@"Enter........");
    [[ZMSDKCommonHelper sharedInstance].myController mouseEntered:theEvent];
}

- (void)mouseExited:(NSEvent *)theEvent
{
    NSLog(@"Exit........");
    [[ZMSDKCommonHelper sharedInstance].myController mouseExited:theEvent];
}

- (IBAction)inviteImageClicked:(id)sender {
}
@end
