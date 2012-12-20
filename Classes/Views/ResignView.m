//
//  ResignView.m
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 20.12.12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

#import "ResignView.h"

@implementation ResignView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

-(void) mouseDown:(NSEvent *)theEvent {
    [[self window] makeFirstResponder:nil];
}

@end
