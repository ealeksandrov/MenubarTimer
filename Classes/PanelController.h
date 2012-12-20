//
//  PanelController.h
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 18.12.12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

#import "BackgroundView.h"
#import "StatusItemView.h"
#import "TimerView.h"
#import "AlarmView.h"
#import "SettingsView.h"

@class PanelController;

@protocol PanelControllerDelegate <NSObject>

@optional

- (StatusItemView *)statusItemViewForPanelController:(PanelController *)controller;

@end

#pragma mark -

@interface PanelController : NSWindowController <NSWindowDelegate,TimerDelegate,AlarmDelegate,SettingsDelegate> {
    BOOL _hasActivePanel;
    int popupHeight;
    NSMutableArray *timersArray;
    bool showAlertWindow;
}

@property (nonatomic, unsafe_unretained) IBOutlet BackgroundView *backgroundView;
@property (nonatomic, unsafe_unretained) IBOutlet BackgroundView *backgroundView2;
@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *noteField;
@property (nonatomic, unsafe_unretained) IBOutlet NSWindow *alertPopup;

@property (nonatomic) BOOL hasActivePanel;
@property (nonatomic, unsafe_unretained, readonly) id<PanelControllerDelegate> delegate;

- (id)initWithDelegate:(id<PanelControllerDelegate>)delegate;

- (void)openPanelDefault:(bool)panelFlag;
- (void)closePanel;
- (void)resignTextControl;

-(IBAction)addTimer:(id)sender;
-(IBAction)addAlarm:(id)sender;
-(IBAction)terminate:(id)sender;
-(IBAction)openPrefs:(id)sender;

-(IBAction)closeMe:(id)sender;

@end
