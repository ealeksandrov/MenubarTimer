//
//  TimerView.h
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 19.12.12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

#import "OnOffSwitchControl.h"
@class TimerView;

@protocol TimerDelegate<NSObject>
@required
- (void)deleteTimer:(NSViewController *)timerInstance;
- (void)fireAlarmWithNote:(NSString *)note;
- (void)object:(NSViewController *)obj switchedTo:(bool)state;
@end

@interface TimerView : NSViewController {
    NSTimer *timer;
    int secondsLeft;
}

@property (nonatomic, assign)id <TimerDelegate> delegate;
@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *timeField;
@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *timeLabel;
@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *noteField;
@property (nonatomic, unsafe_unretained) IBOutlet OnOffSwitchControl *switchControl;
@property (nonatomic, unsafe_unretained) IBOutlet NSSlider *slider;

-(IBAction)deleteMe:(id)sender;
-(IBAction)sliderValueChanged:(id)sender;
-(IBAction)switchActivated:(id)sender;
-(void)timerTick:(id)sender;

@end
