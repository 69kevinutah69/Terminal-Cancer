//
//  AppDelegate.m
//  Terminal Cancer
//
//  Created by @f4bul1z3r on 6/28/17.
//  Copyright © 2017 @f4bul1z3r. All rights reserved.
//
// yea sorry this is shit code use it at your own discretion

#import "AppDelegate.h"
#import "TouchBar.h"

#include <stdio.h>
#import <QuartzCore/QuartzCore.h>
static const NSTouchBarItemIdentifier kTermIdentifier = @"com.f4bul1z3r.Term";
static NSTouchBarItemIdentifier CustomViewIdentifier = @"com.TouchBarCatalog.customView";
static NSTouchBarCustomizationIdentifier CustomViewCustomizationIdentifier = @"com.TouchBarCatalog.customViewViewController";
static const NSTouchBarItemIdentifier scroll = @"com.f4bul1z3r.Scroll";

@interface AppDelegate () <NSTouchBarDelegate,NSTableViewDelegate, NSTableViewDataSource,NSApplicationDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic) NSTouchBar *commands;
@property (weak) IBOutlet NSSegmentedControl *segmentedControl;
@property (weak) IBOutlet NSView *mainView;
@property (weak) IBOutlet NSView *first;
@property (weak) IBOutlet NSView *second;
@property (weak) IBOutlet NSView *third;


@property (weak) IBOutlet NSButton *secondOpenInDefaultEditor;
@property (weak) IBOutlet NSButton *secondSaveChanges;
@property (weak) IBOutlet NSButton *addCommand;
@property (weak) IBOutlet NSButton *firstOpenInDefaultEditor;
@property (weak) IBOutlet NSTextField *firstCommandName;

@property (weak) IBOutlet NSButton *removeCommand;
@property (weak) IBOutlet NSView *v1;
@property (weak) IBOutlet NSView *v2;
@property (weak) IBOutlet NSView *v3;
@property (weak) IBOutlet NSTableView *T2;
@property (weak) IBOutlet NSTableView *T3;
@property (unsafe_unretained) IBOutlet NSTextView *secondEditor;


@property (unsafe_unretained) IBOutlet NSTextView *firstEditor;

@property (nonatomic) NSTouchBar *bar;

@end

@implementation AppDelegate

- (NSTouchBar *)makeTouchBar
{
    if (!_bar){
        
        NSTouchBar *bar = [[NSTouchBar alloc] init];
        bar.delegate = self;
        
        bar.customizationIdentifier = CustomViewCustomizationIdentifier;
       
        bar.defaultItemIdentifiers =
        @[CustomViewIdentifier, NSTouchBarItemIdentifierOtherItemsProxy];
        
        bar.customizationAllowedItemIdentifiers = @[CustomViewIdentifier];
        _bar = bar;
        
    } return _bar;
}
- (void)exec:(NSButton *)sender
{
 NSString *path = [[NSBundle mainBundle] resourcePath];
    NSLog(path);
   
    NSString *chmod = [NSString stringWithFormat:@"chmod +x '%@/Scripts/%@'", path, @(sender.tag)];
    NSLog(chmod);
    NSString *path1 = [NSString stringWithFormat:@"\"%@/Scripts/%@\"", path, @(sender.tag)];
    system([chmod UTF8String]);
    system([path1 UTF8String]);
    
}

- (void)present:(id)sender
{
   

    [NSTouchBar presentSystemModalFunctionBar:self.makeTouchBar systemTrayItemIdentifier:@":)"];
//    show the bear button
}

- (nullable NSTouchBarItem *)touchBar:(NSTouchBar *)touchBar makeItemForIdentifier:(NSTouchBarItemIdentifier)identifier
{
    if ([identifier isEqualToString:CustomViewIdentifier])
    {
        NSView *customView = nil;
        
        
        // Create the custom view that analyzes touch events.
        customView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 685, 30)];
        
        customView.wantsLayer = YES;
        // customView.layer.backgroundColor = [NSColor blueColor].CGColor;
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/Scripts"];
        
        NSArray *directoryContent  = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
        int numOfButtons = [directoryContent count];//---------------------------------
        
        
        NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, 685, 60)];
        
        
        
        NSMutableDictionary *constraintViews = [NSMutableDictionary dictionary];
        
        NSView *documentView = [[NSView alloc] initWithFrame:NSMakeRect(0,0,0,30)];
        
        
        NSString *layoutFormat = @"H:|";
        
        NSSize size = NSMakeSize(0, 30);
        
        int avg = 0;
        NSString* string = @"a";
        for (int i = 1; i <= numOfButtons; i++) {
            
            NSString* string =  [directoryContent objectAtIndex:i-1];
            NSString* fileContents =
            [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,string]
                                      encoding:NSUTF8StringEncoding error:nil];
            
            // first, separate by new line
            NSArray* allLinedStrings =
            [fileContents componentsSeparatedByCharactersInSet:
             [NSCharacterSet newlineCharacterSet]];
            
            // then break down even further
            NSString* strsInOneLine =
            [allLinedStrings objectAtIndex:0];
            
            
            NSString* name = [strsInOneLine substringFromIndex:1];

            NSString *objectName = [NSString stringWithFormat:@"command%@",@(i)];
            
            
            string = [string stringByAppendingString:@"a"];
            
            
            NSString *objectName1 = [NSString stringWithFormat:name];
            
            NSButton *button = [NSButton buttonWithTitle:objectName1
                                                  target:nil
                                                  action:@selector(exec:)];
            button.translatesAutoresizingMaskIntoConstraints = NO;
            button.tag = i;
            [documentView addSubview:button];
            
            // Constraint information
            layoutFormat = [layoutFormat stringByAppendingString:[NSString stringWithFormat:@"-8-[%@]", objectName]];
            [constraintViews setObject:button forKey:objectName];
            size.width += button.intrinsicContentSize.width;
            avg += button.intrinsicContentSize.width;
            avg += 8;
            size.width += 8;
            NSLog(@"%f   %f",button.intrinsicContentSize.width, button.frame.size.width);
            
        }
        //            if (avg < 685){
        //                [scrollView setFrame:NSMakeRect(0, 0, avg, 30)];
        //
        //            }
        // [scrollView setFrame:NSMakeRect(0, 0, avg, 30)];
        layoutFormat = [layoutFormat stringByAppendingString:[NSString stringWithFormat:@"-%d-|", 0]];
        
        NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:layoutFormat
                                                                        options:NSLayoutFormatAlignAllCenterY
                                                                        metrics:nil
                                                                          views:constraintViews];
        //[documentView setWantsLayer:YES];
        
        
        [documentView setFrame:NSMakeRect(0, 0, avg, 30)];
        NSLog(@"%d",avg);
        [NSLayoutConstraint activateConstraints:hConstraints];
        
        scrollView.documentView = documentView;
        documentView.autoresizingMask = NSViewWidthSizable |NSViewMinXMargin|NSViewMaxXMargin;
        scrollView.documentView.autoresizingMask = NSViewWidthSizable |NSViewMinXMargin|NSViewMaxXMargin;
        scrollView.autoresizingMask = NSViewWidthSizable |NSViewMinXMargin|NSViewMaxXMargin;
        
        [customView addSubview:scrollView];
        // NSArray *horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : scrollView}];
        //[customView addConstraints:horizontal];
        customView.autoresizingMask = NSViewWidthSizable |NSViewMinXMargin|NSViewMaxXMargin;
        
        
        // This is so we can report back the view's touch location.
        
        [[scrollView documentView] scrollPoint:NSMakePoint(avg,30)];
        NSCustomTouchBarItem *customViewItem = [[NSCustomTouchBarItem alloc] initWithIdentifier:CustomViewIdentifier];
        customViewItem.view = customView;
        customViewItem.customizationLabel = @"Custom View";
        
        [customView setTranslatesAutoresizingMaskIntoConstraints:NO];
        //[scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [documentView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [scrollView.documentView setTranslatesAutoresizingMaskIntoConstraints:NO];
        return customViewItem;
    }
    
    return nil;
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_mainView addSubview:_v1];
    [_mainView addSubview:_v2];
    [_mainView addSubview:_v3];
    [_v2 setHidden:YES];
    [_v3 setHidden:YES];
   
   NSString *path = [[NSBundle mainBundle] resourcePath];

    NSArray *directoryContent  = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    int numberOfFileInFolder = [directoryContent count];
   
  

   
    
    // first, separate by new line
//    NSArray* allLinedStrings =
//    [fileContents componentsSeparatedByCharactersInSet:
//     [NSCharacterSet newlineCharacterSet]];
    
    // then break down even further
//    NSString* strsInOneLine =
//    [allLinedStrings objectAtIndex:0];

    
    DFRSystemModalShowsCloseBoxWhenFrontMost(YES);

    NSCustomTouchBarItem *term =
        [[NSCustomTouchBarItem alloc] initWithIdentifier:kTermIdentifier];
    term.view = [NSButton buttonWithTitle:@"🖕" target:self action:@selector(present:)];
    [NSTouchBarItem addSystemTrayItem:term];
    DFRElementSetControlStripPresenceForIdentifier(kTermIdentifier, YES);
 
   
}
- (IBAction)buttonClicked:(id)sender {
    NSButton *b = (NSButton*)sender;
    NSLog(@"Button pressed: %@", @(b.tag));
    NSString *path = [[NSBundle mainBundle] resourcePath];
   
    NSArray *directoryContent  = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Scripts",path] error:nil];
    int numberOfFilesInFolder = [directoryContent count];
    
    
    NSLog(@"%d", numberOfFilesInFolder);
    if (b.tag == 1){
        
    } else if (b.tag == 2){
        //add new command
        
        NSLog(@"%@",_firstEditor.string);
        NSString *contents1 = [NSString stringWithFormat:@"#%@\r\n%@", _firstCommandName.stringValue , _firstEditor.string];
   

        int a = [[NSFileManager defaultManager] createFileAtPath:[NSString stringWithFormat:@"%@/Scripts/%d", path, numberOfFilesInFolder+1] contents:nil attributes:nil];
        if (!a) {
            
            NSLog(@"ERRORRRRR");
        }
        NSLog(@"%@", [NSString stringWithFormat:@"%@/Scripts/%d", path, numberOfFilesInFolder+1]);
        [contents1 writeToFile:[NSString stringWithFormat:@"%@/Scripts/%d", path, numberOfFilesInFolder+1] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [_T2 reloadData];
        [_T3 reloadData];
        _firstCommandName.stringValue = @"";
        _firstEditor.string = @"";
        
        
    } else if (b.tag == 3){
        
    } else if (b.tag == 4){
        
        NSLog(@"%@",_firstEditor.string);
        NSString *contents1 = [NSString stringWithFormat:@"%@",_secondEditor.string];
        
        
        
        int a = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Scripts/%ld", path, (long)_T2.selectedRow+1]];
        if (a){
        [contents1 writeToFile:[NSString stringWithFormat:@"%@/Scripts/%ld", path, (long)_T2.selectedRow+1] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        [_T2 reloadData];
        [_T3 reloadData];
        _firstCommandName.stringValue = @"";
        _firstEditor.string = @"";
        
    } else if (b.tag == 5){
    
        
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/Scripts/%ld", path, (long)_T3.selectedRow+1]error:nil];
        for (int e = _T3.selectedRow+1; e <= numberOfFilesInFolder; e ++){
            NSLog([NSString stringWithFormat:@"e = %d",e]);
            
            [[NSFileManager defaultManager] moveItemAtPath:[NSString stringWithFormat:@"%@/Scripts/%ld", path, e] toPath:[NSString stringWithFormat:@"%@/Scripts/%ld", path, e-1]error:nil];
        }
        [_T2 reloadData];
        [_T3 reloadData];
    }
    

}

- (IBAction)segmentedControlAction:(id)sender
{
    
    
    if (_segmentedControl.selectedSegment==0)
    {
        [_v1 setHidden:NO];
        [_v2 setHidden:YES];
        [_v3 setHidden:YES];
        [_T2 reloadData];
             [_T3 reloadData];
    }
    else if(_segmentedControl.selectedSegment==1)
    {
        [_v2 setHidden:NO];
        [_v1 setHidden:YES];
        [_v3 setHidden:YES];
        [_T2 reloadData];
        [_T3 reloadData];
        _secondEditor.string = @"<Please select a command";
    }else if(_segmentedControl.selectedSegment==2){
        [_v2 setHidden:YES];
        [_v1 setHidden:YES];
        [_v3 setHidden:NO];
        [_T2 reloadData];
        [_T3 reloadData];
        
    }
}
- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}





- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    
 
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/Scripts"];
    
    NSArray *directoryContent  = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    int numberOfFileInFolder = [directoryContent count];
    return numberOfFileInFolder;
}

- (id)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/Scripts"];
    NSArray *directoryContent  = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSString* string =  [directoryContent objectAtIndex:row];
    NSString* fileContents =
    [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,string]
                              encoding:NSUTF8StringEncoding error:nil];
    
    
    NSArray* allLinedStrings =
    [fileContents componentsSeparatedByCharactersInSet:
     [NSCharacterSet newlineCharacterSet]];
    
    
    NSString* strsInOneLine =
    [allLinedStrings objectAtIndex:0];
    
    
    NSString* name = [strsInOneLine substringFromIndex:1];
      NSString* sample = [fileContents substringFromIndex:name.length+1];
    sample = [sample stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
     sample = [sample stringByReplacingOccurrencesOfString:@"\r" withString:@" "];

    
    
    NSLog(@"%@", sample);
    
  
    
    NSTableCellView *aTableCellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
     aTableCellView.textField.stringValue = sample;
    if ([tableColumn.identifier isEqualToString:@"Commands"]) {
        aTableCellView.textField.stringValue = name;
    }
    else{//if ([tableColumn.identifier isEqualToString:@"Sample"]) {
       
    }
    
    
    
    return aTableCellView;
    
}
        
   // }
   // return nil;
- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    
    
    NSTableView *tableView = notification.object;
    NSLog(@"User has selected row %ld", (long)tableView.selectedRow);
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/Scripts"];
    NSArray *directoryContent  = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSString* string =  [directoryContent objectAtIndex:tableView.selectedRow];
    NSString* fileContents =
    [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,string]
                              encoding:NSUTF8StringEncoding error:nil];
    
    // first, separate by new line
    NSArray* allLinedStrings =
    [fileContents componentsSeparatedByCharactersInSet:
     [NSCharacterSet newlineCharacterSet]];
    
    // then break down even further
    NSString* strsInOneLine =
    [allLinedStrings objectAtIndex:0];
    
    
    NSString* name = [strsInOneLine substringFromIndex:1];
  
//:)
    
    
    

    
    //if ([tableColumn.identifier isEqualToString:@"Commands"]) {
    
    // first colum (numbers)
    // return name;
    
   
    
    
    
   

    if (!_v2.isHidden){
        _secondEditor.string = fileContents;
    }
}


@end

