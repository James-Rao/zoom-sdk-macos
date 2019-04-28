//
//  MyGroupManageTableCellView.h
//  ZoomSDKSample
//
//  Created by Yongquan Rao on 2019/4/28.
//  Copyright © 2019 TOTTI. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UserInfo.h"

@interface MyGroupManageTableCellView : NSTableCellView
{
    UserInfo* _user;
    Group* _group;
    BOOL _isIn;
    BOOL _isIn_Old;
}

@property (assign) IBOutlet NSImageView *imageViewOnline;


@property (assign) IBOutlet NSTextField *textFieldOnline;

@property (assign) IBOutlet NSButton *isCheckedButton;

- (void)updateUI:(Group*)group theUser:(UserInfo*)user;

@property (nonatomic, assign, readwrite) BOOL isIn;
@property (nonatomic, assign, readwrite) BOOL isIn_Old;
@property (nonatomic, assign, readwrite) UserInfo* user;
@property (nonatomic, assign, readwrite) Group* group;

- (IBAction)isInChecked:(id)sender;


@end
