//
//  AlarmView.h
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 12/19/12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

#import "OnOffSwitchControl.h"
@class AlarmView;

@protocol AlarmDelegate<NSObject>
@required
- (void)deleteTimer:(NSViewController *)timerInstance;
- (void)fireAlarmWithNote:(NSString *)note;
@end


@interface AlarmView : NSViewController {
    NSTimer *timer;
}

@property (nonatomic, assign)id <AlarmDelegate> delegate;
@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *noteField;
@property (nonatomic, unsafe_unretained) IBOutlet NSDatePicker *datePicker;
@property (nonatomic, unsafe_unretained) IBOutlet OnOffSwitchControl *switchControl;

-(IBAction)deleteMe:(id)sender;
-(IBAction)switchActivated:(id)sender;
-(void)timerTick:(id)sender;

@end
