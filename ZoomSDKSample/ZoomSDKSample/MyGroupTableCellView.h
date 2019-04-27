//
//  MyGroupTableCellView.h
//  ZoomSDKSample
//
//  Created by Yongquan Rao on 2019/4/27.
//  Copyright © 2019 TOTTI. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UserInfo.h"

@interface MyGroupTableCellView : NSTableCellView
{
    Group* _group;
}
@property (assign) IBOutlet NSButton *inviteButton;
@property (assign) IBOutlet NSButton *editButton;
@property (assign) IBOutlet NSButton *deleteButton;
@property (assign) IBOutlet NSButton *groupmanageButton;


- (IBAction)onDeleteClicked:(id)sender;
- (IBAction)onEditClicked:(id)sender;
- (IBAction)onInviteClicked:(id)sender;
- (IBAction)onGroupmanageClicked:(id)sender;

- (void) updateUI: (Group*) group;
@end
