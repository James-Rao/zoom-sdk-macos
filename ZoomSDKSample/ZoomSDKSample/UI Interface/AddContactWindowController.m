//
//  AddContactWindowController.m
//  ZoomSDKSample
//
//  Created by Yongquan Rao on 2019/4/11.
//  Copyright © 2019 TOTTI. All rights reserved.
//

#import "AddContactWindowController.h"
#import "ZMSDKMainWindowController.h"

@interface AddContactWindowController ()
@end

@implementation AddContactWindowController
@synthesize parent = _parent;

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)AddButtonClicked:(id)sender {
    ((ZMSDKMainWindowController*)_parent).isContactAdded = YES;
    ((ZMSDKMainWindowController*)_parent).contactEmail = [_contactEmail stringValue];
    
    [NSApp stopModalWithCode:NSModalResponseOK];
    [NSApp endSheet:self.window];
}

- (IBAction)CancelButtonClicked:(id)sender {
    ((ZMSDKMainWindowController*)_parent).isContactAdded = NO;
    
    [NSApp stopModalWithCode:NSModalResponseCancel];
    [NSApp endSheet:self.window];
}
@end
