//
//  AlertView.m
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 12/19/12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

#import "AlertView.h"

@interface AlertView ()

@end

@implementation AlertView

-(id)initWithMessage:(NSString *)note {
    self = [self initWithWindowNibName:@"AlertView"];
    if(self) {
        _note=note;
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    if(_note && [_note length]>0)
        [self.noteField setStringValue:_note];
    else
        [self.noteField setStringValue:@"Close me!"];
}

- (void)windowWillClose:(NSNotification *)notification
{
    [NSApp stopModal];
}

-(IBAction)close:(id)sender {
    [[self window] close];
}

@end
