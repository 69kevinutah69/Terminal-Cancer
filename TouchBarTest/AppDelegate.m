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
static NSTouchBarItemIdentifier CustomViewIdentifier = @"com.TouchBarCatalog.customView";
static NSTouchBarCustomizationIdentifier CustomViewCustomizationIdentifier = @"com.TouchBarCatalog.customViewViewController";
static const NSTouchBarItemIdentifier kTermIdentifier = @"com.f4bul1z3r.Term";

static const NSTouchBarItemIdentifier scroll = @"com.f4bul1z3r.Scroll";

@interface AppDelegate () <NSTouchBarDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic) NSTouchBar *bar;

@end

@implementation AppDelegate
int stuff = 0;

- (NSTouchBar *)makeTouchBar
{
if (!_bar){
    
    NSTouchBar *bar = [[NSTouchBar alloc] init];
    bar.delegate = self;
    
    bar.customizationIdentifier = CustomViewCustomizationIdentifier;
    
    // Set the default ordering of items.
    bar.defaultItemIdentifiers =
    @[CustomViewIdentifier, NSTouchBarItemIdentifierOtherItemsProxy];
    
    bar.customizationAllowedItemIdentifiers = @[CustomViewIdentifier];
    _bar = bar;
   
} return _bar;
}
- (void)exec:(NSButton *)sender
{
    NSString *path = [[NSFileManager defaultManager] currentDirectoryPath];
 
   
    NSString *filename = [NSString stringWithFormat:@"%@/%@", path, @(sender.tag)];
    NSLog(filename);
}

- (void)present:(id)sender
{
    

    [NSTouchBar presentSystemModalFunctionBar:self.makeTouchBar systemTrayItemIdentifier:@":)"];
    
    
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
        
        int numOfButtons = 10;//---------------------------------
        
            
            NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, 685, 60)];
        
        
        
            NSMutableDictionary *constraintViews = [NSMutableDictionary dictionary];
        
            NSView *documentView = [[NSView alloc] initWithFrame:NSMakeRect(0,0,0,30)];
        
        
            NSString *layoutFormat = @"H:|";
        
            NSSize size = NSMakeSize(0, 30);
        
            int avg = 0;
            NSString* string = @"a";
            for (int i = 1; i <= numOfButtons; i++) {
                NSString *objectName = [NSString stringWithFormat:@"command%@",@(i)];
                
                
                string = [string stringByAppendingString:@"a"];
                
                
                NSString *objectName1 = [NSString stringWithFormat:@"Command %d",(int)i];
                
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
    
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    NSImage *menuIcon = [NSImage imageNamed:@"ico.png"];
    NSImage *highlightIcon = [NSImage imageNamed:@"ico.png"]; // Yes, we're using the exact same image asset.
    [highlightIcon setTemplate:YES]; // Allows the correct highlighting of the icon when the menu is clicked.
    
    [[self statusItem] setImage:menuIcon];
    [[self statusItem] setAlternateImage:highlightIcon];
    [[self statusItem] setMenu:[self menu]];
    [[self statusItem] setHighlightMode:YES];
    
    DFRSystemModalShowsCloseBoxWhenFrontMost(YES);

    NSCustomTouchBarItem *term =
        [[NSCustomTouchBarItem alloc] initWithIdentifier:kTermIdentifier];
    term.view = [NSButton buttonWithTitle:@"🖕" target:self action:@selector(present:)];
    [NSTouchBarItem addSystemTrayItem:term];
    DFRElementSetControlStripPresenceForIdentifier(kTermIdentifier, YES);
 
   
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}
//format for the command line file
/*
#NAME
#!/bin/bash
 
 commands etc...
 
 */
@end
