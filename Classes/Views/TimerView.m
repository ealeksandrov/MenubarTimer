//
//  TimerView.m
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 19.12.12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

#import "TimerView.h"

@implementation TimerView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        secondsLeft=15*60;
    }
    
    return self;
}

-(IBAction)deleteMe:(id)sender {
    [self.delegate deleteTimer:self];
}

-(IBAction)switchActivated:(id)sender {
    
    [[self.view window] makeFirstResponder:nil];
    
    if(self.switchControl.state) {
        if(secondsLeft<1)
            [self.switchControl setState:0];
        else {
            [timer invalidate];
            timer=[NSTimer scheduledTimerWithTimeInterval:1.0
                                               target:self
                                             selector:@selector(timerTick:)
                                             userInfo:nil
                                              repeats:YES];
        }
    } else {
        [timer invalidate];
    }
}

-(IBAction)sliderValueChanged:(id)sender {
    
    [[self.view window] makeFirstResponder:nil];
    
    NSSlider *slider = (NSSlider *)sender;
    secondsLeft=60*slider.intValue;
    [self.timeField setStringValue:[NSString stringWithFormat:@"%d",slider.intValue]];
    if(secondsLeft<120) {
        [self.timeLabel setStringValue:@"minute left"];
    } else {
        [self.timeLabel setStringValue:@"minutes left"];
    }
    if(self.switchControl.state) {
        [timer invalidate];
        timer=[NSTimer scheduledTimerWithTimeInterval:1.0
                                           target:self
                                         selector:@selector(timerTick:)
                                         userInfo:nil
                                          repeats:YES];
    }
}

-(void)timerTick:(id)sender {
    secondsLeft--;
    if(secondsLeft>60&&secondsLeft<120) {
        [self.timeField setStringValue:[NSString stringWithFormat:@"%d",secondsLeft/60]];
        [self.timeLabel setStringValue:@"minute left"];
    } else if(secondsLeft>60) {
        [self.timeField setStringValue:[NSString stringWithFormat:@"%d",secondsLeft/60]];
        [self.timeLabel setStringValue:@"minutes left"];
    } else {
        [self.timeField setStringValue:[NSString stringWithFormat:@"%d",secondsLeft]];
        [self.timeLabel setStringValue:@"seconds left"];
    }
    [self.slider setFloatValue:secondsLeft/60];
    
    if (secondsLeft<1) {
        [self.switchControl setState:0];
        [self.delegate fireAlarmWithNote:[self.noteField stringValue]];
        [timer invalidate];
        timer=nil;
    }
}

@end
