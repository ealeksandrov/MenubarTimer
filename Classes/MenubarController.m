//
//  MenubarController.m
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 18.12.12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

#import "MenubarController.h"
#import "StatusItemView.h"

@implementation MenubarController

#pragma mark -

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        // Install status item into the menu bar
        NSStatusItem *statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:STATUS_ITEM_VIEW_WIDTH];
        _statusItemView = [[StatusItemView alloc] initWithStatusItem:statusItem];
        _statusItemView.image = [NSImage imageNamed:@"alarm_off"];
        _statusItemView.alternateImage = [NSImage imageNamed:@"alarm"];
        _statusItemView.action = @selector(togglePanel:);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(turnIconOn) name:@"turnIconOn" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(turnIconOff) name:@"turnIconOff" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
}

#pragma mark -
#pragma mark Public accessors

- (NSStatusItem *)statusItem
{
    return self.statusItemView.statusItem;
}

#pragma mark -

- (BOOL)hasActiveIcon
{
    return self.statusItemView.isHighlighted;
}

- (void)setHasActiveIcon:(BOOL)flag
{
    self.statusItemView.isHighlighted = flag;
}

- (BOOL)hasTimerIcon
{
    return self.statusItemView.isTimer;
}

- (void)setHasTimerIcon:(BOOL)flag
{
    self.statusItemView.isTimer = flag;
}

-(void)turnIconOn {
    self.hasTimerIcon=YES;
    NSLog(@"sad");
}

-(void)turnIconOff {
    self.hasTimerIcon=NO;
    NSLog(@"sad2");
}

@end
