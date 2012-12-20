//
//  PanelController.m
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 18.12.12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

#import "PanelController.h"
#import "BackgroundView.h"
#import "StatusItemView.h"
#import "MenubarController.h"
#import "NSView+Animations.h"
#import "AlertView.h"

#define OPEN_DURATION .15
#define CLOSE_DURATION .1

#define SEARCH_INSET 17

#define POPUP_HEIGHT 85
#define PANEL_WIDTH 280
#define MENU_ANIMATION_DURATION .1

#define DY 140

#pragma mark -

@implementation PanelController

@synthesize hasActivePanel=_hasActivePanel;

#pragma mark -

- (id)initWithDelegate:(id<PanelControllerDelegate>)delegate
{
    self = [super initWithWindowNibName:@"Panel"];
    if (self != nil)
    {
        _delegate = delegate;
        popupHeight=POPUP_HEIGHT;
        timersArray = [NSMutableArray array];
        showAlertWindow=YES;
    }
    return self;
}

- (void)dealloc
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(IBAction)terminate:(id)sender {
    [[NSApplication sharedApplication] terminate:self];
}

-(IBAction)addTimer:(id)sender {
    [self resignTextControl];
    
    if([timersArray count]<5) {
        NSRect oldFrame = [[self window] frame];
        oldFrame.size.height += DY;
        oldFrame.origin.y -= DY;
        [[self window] setFrame:oldFrame display:YES animate:YES];
    
        TimerView *newTimer = [[TimerView alloc] initWithNibName:@"TimerView" bundle:nil];
        newTimer.delegate=self;
        [self.backgroundView addSubview:newTimer.view animated:YES];
        [timersArray addObject:newTimer];
        }
}

-(IBAction)addAlarm:(id)sender {
    [self resignTextControl];
    
    if([timersArray count]<5) {
        NSRect oldFrame = [[self window] frame];
        oldFrame.size.height += DY;
        oldFrame.origin.y -= DY;
        [[self window] setFrame:oldFrame display:YES animate:YES];
        
        AlarmView *newAlarm = [[AlarmView alloc] initWithNibName:@"AlarmView" bundle:nil];
        newAlarm.delegate=self;
        [self.backgroundView addSubview:newAlarm.view animated:YES];
        [timersArray addObject:newAlarm];
    }
}

-(void) resignTextControl {
    [[self window] makeFirstResponder:nil];
}

-(void) deleteTimer:(NSViewController *)timerInstance {
    [self resignTextControl];
    
    NSUInteger delIndex = [timersArray indexOfObject:timerInstance];
    [timersArray removeObject:timerInstance];
    [timerInstance.view removeFromSuperviewAnimated:YES];
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:1.0f]; // However long you want the slide to take
        
    for (NSViewController *timer in timersArray) {
        if ([timersArray indexOfObject:timer]>=delIndex) {
            CGRect oldFrame = timer.view.frame;
            //oldFrame.origin.y+= DY;
            [[timer.view animator] setFrame:oldFrame];
        }
    }
    [NSAnimationContext endGrouping];
    
    NSRect oldFrame = [[self window] frame];
    oldFrame.size.height -= DY;
    oldFrame.origin.y += DY;
    [[self window] setFrame:oldFrame display:YES animate:YES];
}

- (void)fireAlarmWithNote:(NSString *)note {
    if(showAlertWindow) {
    AlertView *view = [[AlertView alloc] initWithMessage:note];
    NSWindow *window = view.window;
    [NSApp activateIgnoringOtherApps:YES];
    [window setLevel:NSPopUpMenuWindowLevel];
    [NSApp runModalForWindow:window];
    } else {
        if(note && [note length]>0)
            [self.noteField setStringValue:note];
        else
            [self.noteField setStringValue:@"Close me!"];
        
        if(_hasActivePanel) {
            [self closePanel];
            dispatch_after(dispatch_walltime(NULL, NSEC_PER_SEC * CLOSE_DURATION * 2), dispatch_get_main_queue(), ^{
                _hasActivePanel = YES;
                [self openPanelDefault:NO];
            });
        } else {
            _hasActivePanel = YES;
            [self openPanelDefault:NO];
        }
    }
}

-(IBAction)openPrefs:(id)sender {
    [self resignTextControl];
    
    SettingsView *view = [[SettingsView alloc] initWithSetting:showAlertWindow];
    view.delegate=self;
    NSWindow *window = view.window;
    [NSApp activateIgnoringOtherApps:YES];
    [window setLevel:NSPopUpMenuWindowLevel];
    [NSApp runModalForWindow:window];
    
}

-(void)saveSetting:(bool)showWindow {
    showAlertWindow=showWindow;
}

#pragma mark -

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Make a fully skinned panel
    NSPanel *panel = (id)[self window];
    [panel setAcceptsMouseMovedEvents:YES];
    [panel setLevel:NSPopUpMenuWindowLevel];
    [panel setOpaque:NO];
    [panel setBackgroundColor:[NSColor clearColor]];
    
    // Resize panel
    NSRect panelRect = [[self window] frame];
    panelRect.size.height = POPUP_HEIGHT;
    [[self window] setFrame:panelRect display:NO];
    
    
    NSPanel *panel2 = (id)[self alertPopup];
    [panel2 setAcceptsMouseMovedEvents:YES];
    [panel2 setLevel:NSPopUpMenuWindowLevel];
    [panel2 setOpaque:NO];
    [panel2 setBackgroundColor:[NSColor clearColor]];
    
    // Resize panel
    NSRect panelRect2 = [[self alertPopup] frame];
    panelRect2.size.height = POPUP_HEIGHT;
    [[self alertPopup] setFrame:panelRect2 display:NO];
}

#pragma mark - Public accessors

- (BOOL)hasActivePanel
{
    return _hasActivePanel;
}

- (void)setHasActivePanel:(BOOL)flag
{
    if([[self alertPopup] isVisible] && flag)
    {
        [self closePanel];
        dispatch_after(dispatch_walltime(NULL, NSEC_PER_SEC * CLOSE_DURATION * 2), dispatch_get_main_queue(), ^{
            _hasActivePanel = YES;
            [self openPanelDefault:YES];
        });
    }
    
    if (_hasActivePanel != flag)
    {
        _hasActivePanel = flag;
        
        if (_hasActivePanel)
        {
            [self openPanelDefault:YES];
        }
        else
        {
            [self closePanel];
        }
    }
}

#pragma mark - NSWindowDelegate

- (void)windowWillClose:(NSNotification *)notification
{
    self.hasActivePanel = NO;
}

- (void)windowDidResignKey:(NSNotification *)notification;
{
    if ([[self window] isVisible])
    {
        self.hasActivePanel = NO;
    } else if([[self alertPopup] isVisible])
    {
        self.hasActivePanel = NO;
    }
}

- (void)windowDidResize:(NSNotification *)notification
{
    NSWindow *panel = [self window];
    NSRect statusRect = [self statusRectForWindow:panel];
    NSRect panelRect = [panel frame];
    
    CGFloat statusX = roundf(NSMidX(statusRect));
    CGFloat panelX = statusX - NSMinX(panelRect);
    
    self.backgroundView.arrowX = panelX;
    self.backgroundView2.arrowX = panelX;
}

#pragma mark - Keyboard

- (void)cancelOperation:(id)sender
{
    self.hasActivePanel = NO;
}

#pragma mark - Public methods

- (NSRect)statusRectForWindow:(NSWindow *)window
{
    NSRect screenRect = [[[NSScreen screens] objectAtIndex:0] frame];
    NSRect statusRect = NSZeroRect;
    
    StatusItemView *statusItemView = nil;
    if ([self.delegate respondsToSelector:@selector(statusItemViewForPanelController:)])
    {
        statusItemView = [self.delegate statusItemViewForPanelController:self];
    }
    
    if (statusItemView)
    {
        statusRect = statusItemView.globalRect;
        statusRect.origin.y = NSMinY(statusRect) - NSHeight(statusRect);
    }
    else
    {
        statusRect.size = NSMakeSize(STATUS_ITEM_VIEW_WIDTH, [[NSStatusBar systemStatusBar] thickness]);
        statusRect.origin.x = roundf((NSWidth(screenRect) - NSWidth(statusRect)) / 2);
        statusRect.origin.y = NSHeight(screenRect) - NSHeight(statusRect) * 2;
    }
    return statusRect;
}

- (void)openPanelDefault:(bool)panelFlag
{
    NSWindow *panel = panelFlag ? [self window] : [self alertPopup];
    
    NSRect screenRect = [[[NSScreen screens] objectAtIndex:0] frame];
    NSRect statusRect = [self statusRectForWindow:panel];
    
    NSRect panelRect = [panel frame];
    panelRect.size.width = PANEL_WIDTH;
    panelRect.origin.x = roundf(NSMidX(statusRect) - NSWidth(panelRect) / 2);
    panelRect.origin.y = NSMaxY(statusRect) - NSHeight(panelRect);
    
    if (NSMaxX(panelRect) > (NSMaxX(screenRect) - ARROW_HEIGHT))
        panelRect.origin.x -= NSMaxX(panelRect) - (NSMaxX(screenRect) - ARROW_HEIGHT);
    
    [NSApp activateIgnoringOtherApps:NO];
    [panel setAlphaValue:0];
    [panel setFrame:statusRect display:YES];
    [panel makeKeyAndOrderFront:nil];
    
    NSTimeInterval openDuration = OPEN_DURATION;
    
    NSEvent *currentEvent = [NSApp currentEvent];
    if ([currentEvent type] == NSLeftMouseDown)
    {
        NSUInteger clearFlags = ([currentEvent modifierFlags] & NSDeviceIndependentModifierFlagsMask);
        BOOL shiftPressed = (clearFlags == NSShiftKeyMask);
        BOOL shiftOptionPressed = (clearFlags == (NSShiftKeyMask | NSAlternateKeyMask));
        if (shiftPressed || shiftOptionPressed)
        {
            openDuration *= 10;
            
            if (shiftOptionPressed)
                NSLog(@"Icon is at %@\n\tMenu is on screen %@\n\tWill be animated to %@",
                      NSStringFromRect(statusRect), NSStringFromRect(screenRect), NSStringFromRect(panelRect));
        }
    }
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:openDuration];
    [[panel animator] setFrame:panelRect display:YES];
    [[panel animator] setAlphaValue:1];
    [NSAnimationContext endGrouping];
}

-(IBAction)closeMe:(id)sender {
    self.hasActivePanel = NO;
}

- (void)closePanel
{
    bool panelFlag = [[self window] isVisible];
    NSWindow *windowToClose = panelFlag ? [self window] : [self alertPopup];
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:CLOSE_DURATION];
    [[windowToClose animator] setAlphaValue:0];
    [NSAnimationContext endGrouping];
    
    dispatch_after(dispatch_walltime(NULL, NSEC_PER_SEC * CLOSE_DURATION * 2), dispatch_get_main_queue(), ^{
        
        [windowToClose orderOut:nil];
    });
}

@end
