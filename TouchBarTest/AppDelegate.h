//
//  AppDelegate.h
//  Terminal Cancer
//
//  Created by @f4bul1z3r on 6/28/17.
//  Copyright © 2017 @f4bul1z3r. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (readwrite, retain) IBOutlet NSMenu *menu;
@property (readwrite, retain) IBOutlet NSStatusItem *statusItem;

- (IBAction)menuAction:(id)sender;

@end

@interface tableController : NSObject <NSTableViewDataSource>
@property (weak) IBOutlet NSTableView *T1;
@property (weak) IBOutlet NSTableView *T2;


@end
