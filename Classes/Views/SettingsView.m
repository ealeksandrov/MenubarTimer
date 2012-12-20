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

-(id)initWithSetting:(bool)setting {
    self = [self initWithWindowNibName:@"SettingsView"];
    if(self) {
        selectedWindow = setting;
    }
    
    return self;
}

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
    
    if(selectedWindow)
        [self.radioGroup selectCellAtRow:1 column:0];
}

- (void)windowWillClose:(NSNotification *)notification
{
    if(self.radioGroup.selectedRow)
        [self.delegate saveSetting:YES];
    else
        [self.delegate saveSetting:NO];
    [NSApp stopModal];
}

-(IBAction)close:(id)sender {
    [[self window] close];
}

@end
