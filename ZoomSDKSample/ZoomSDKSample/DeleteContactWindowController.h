//
//  DeleteContactWindowController.h
//  ZoomSDKSample
//
//  Created by Yongquan Rao on 2019/4/25.
//  Copyright © 2019 TOTTI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DeleteContactWindowController : NSWindowController
{
    BOOL _isDelete;
}
- (IBAction)confirmDeleteClicked:(id)sender;
- (IBAction)cancelDeleteClicked:(id)sender;

@property(nonatomic, readwrite)BOOL isDelete;
@end
