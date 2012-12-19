//
//  SettingsView.m
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 19.12.12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

#import "SettingsView.h"

@interface SettingsView ()

@end

@implementation SettingsView

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)windowWillClose:(NSNotification *)notification
{
    [NSApp stopModal];
}

-(IBAction)close:(id)sender {
    [[self window] close];
}

@end
