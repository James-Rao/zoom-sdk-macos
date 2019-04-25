//
//  DeleteContactWindowController.m
//  ZoomSDKSample
//
//  Created by Yongquan Rao on 2019/4/25.
//  Copyright © 2019 TOTTI. All rights reserved.
//

#import "DeleteContactWindowController.h"

@interface DeleteContactWindowController ()

@end

@implementation DeleteContactWindowController

@synthesize isDelete = _isDelete;


- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)confirmDeleteClicked:(id)sender {
    [NSApp stopModalWithCode:NSModalResponseOK];
    _isDelete = YES;
    [NSApp endSheet:self.window];
}

- (IBAction)cancelDeleteClicked:(id)sender {
    [NSApp stopModalWithCode:NSModalResponseCancel];
    _isDelete = NO;
    [NSApp endSheet:self.window];
}
@end
