//
//  AddGroupWindowController.m
//  ZoomSDKSample
//
//  Created by Yongquan Rao on 2019/4/23.
//  Copyright © 2019 TOTTI. All rights reserved.
//

#import "AddGroupWindowController.h"
#import "ZMSDKMainWindowController.h"

@interface AddGroupWindowController ()

@end

@implementation AddGroupWindowController

@synthesize parent = _parent;

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)onAddGroupButtonClicked:(id)sender {
    ((ZMSDKMainWindowController*)_parent).isGroupAdded = YES;
    ((ZMSDKMainWindowController*)_parent).newGroup = [_textfieldGroup stringValue];
    
    [NSApp stopModalWithCode:NSModalResponseOK];
    [NSApp endSheet:self.window];
}

- (IBAction)onCancelGroupButtonClicked:(id)sender {
    ((ZMSDKMainWindowController*)_parent).isGroupAdded = NO;
    
    [NSApp stopModalWithCode:NSModalResponseCancel];
    [NSApp endSheet:self.window];
}
@end
