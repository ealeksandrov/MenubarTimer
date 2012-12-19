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

@class PanelController;

@protocol PanelControllerDelegate <NSObject>

@optional

- (StatusItemView *)statusItemViewForPanelController:(PanelController *)controller;

@end

#pragma mark -

@interface PanelController : NSWindowController <NSWindowDelegate,TimerDelegate> {
    BOOL _hasActivePanel;
    int popupHeight;
    NSMutableArray *timersArray;
}

@property (nonatomic, unsafe_unretained) IBOutlet BackgroundView *backgroundView;
@property (nonatomic, unsafe_unretained) IBOutlet NSSearchField *searchField;
@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *textField;

@property (nonatomic) BOOL hasActivePanel;
@property (nonatomic, unsafe_unretained, readonly) id<PanelControllerDelegate> delegate;

- (id)initWithDelegate:(id<PanelControllerDelegate>)delegate;

- (void)openPanel;
- (void)closePanel;

-(IBAction)more:(id)sender;
-(IBAction)less:(id)sender;

@end
