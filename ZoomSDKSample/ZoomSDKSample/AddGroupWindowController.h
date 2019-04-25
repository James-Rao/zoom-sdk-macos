//
//  AddGroupWindowController.h
//  ZoomSDKSample
//
//  Created by Yongquan Rao on 2019/4/23.
//  Copyright © 2019 TOTTI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AddGroupWindowController : NSWindowController
{
    NSWindowController* _parent;
}

@property(nonatomic, retain, readwrite)NSWindowController* parent;

@property (assign) IBOutlet NSTextField *textfieldGroup;


- (IBAction)onAddGroupButtonClicked:(id)sender;
- (IBAction)onCancelGroupButtonClicked:(id)sender;


@end
