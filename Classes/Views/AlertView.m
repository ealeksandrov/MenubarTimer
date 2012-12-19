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
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
