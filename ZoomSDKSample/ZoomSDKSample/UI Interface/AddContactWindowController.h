//
//  AddContactWindowController.h
//  ZoomSDKSample
//
//  Created by Yongquan Rao on 2019/4/11.
//  Copyright © 2019 TOTTI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AddContactWindowController : NSWindowController
{
    NSWindowController* _parent;
}
@property(nonatomic, retain, readwrite)NSWindowController* parent;

@property (assign) IBOutlet NSTextField *contactEmail;
- (IBAction)AddButtonClicked:(id)sender;
- (IBAction)CancelButtonClicked:(id)sender;

@end
