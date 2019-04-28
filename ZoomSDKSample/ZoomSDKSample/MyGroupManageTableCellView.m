//
//  MyGroupManageTableCellView.m
//  ZoomSDKSample
//
//  Created by Yongquan Rao on 2019/4/28.
//  Copyright © 2019 TOTTI. All rights reserved.
//

#import "MyGroupManageTableCellView.h"

@implementation MyGroupManageTableCellView

@synthesize isIn = _isIn;
@synthesize isIn_Old = _isIn_Old;
@synthesize group = _group;
@synthesize user = _user;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)updateUI: (Group*) group theUser:(UserInfo*)user
{
    _group = group;
    _user = user;
    
    _isIn_Old = NO;
    
    for (int i = 0; i < [_group.contacts count]; ++i) {
        UserInfo* groupUser = (UserInfo*)[_group.contacts objectAtIndex:i];
        if ([groupUser.userEmail isEqualToString:_user.userEmail]) {
            _isIn_Old = YES;
            break;
        }
    }
    
    _isCheckedButton.state = _isIn_Old;
    _isIn = _isIn_Old;
    
    if (_user.status == USERSTATUS_OFFLINE) {
        self.imageViewOnline.image = [NSImage imageNamed:@"offline"];
        self.textFieldOnline.stringValue = @"离线";
    } else {
        self.imageViewOnline.image = [NSImage imageNamed:@"online"];
        self.textFieldOnline.stringValue = @"在线";
    }

}

- (IBAction)isInChecked:(id)sender {
    _isIn = !_isIn;
}
@end
