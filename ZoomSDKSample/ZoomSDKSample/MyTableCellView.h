//
//  MyOutlineView.h
//  ZoomSDKSample
//
//  Created by Yongquan Rao on 2019/4/24.
//  Copyright © 2019 TOTTI. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UserInfo.h"

@interface MyTableCellView : NSTableCellView
{
    NSImage* _mouseOnImage;
    NSImage* _mouseOffImage;
    UserInfo* _userInfo;
}

@property (assign) IBOutlet NSTextField *textOnline;
@property (assign) IBOutlet NSButton *inviteButton;

@property (assign) IBOutlet NSTextField *textOffline;
- (IBAction)deleteButtonClicked:(id)sender;

- (void) updateUI: (UserInfo*) userInfo;
@property (assign) IBOutlet NSButton *deleteButton;

@end


