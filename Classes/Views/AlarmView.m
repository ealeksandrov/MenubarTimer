//
//  AlarmView.m
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 12/19/12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

#import "AlarmView.h"

@implementation AlarmView

-(IBAction)deleteMe:(id)sender {
    [self.delegate deleteTimer:self];
}

-(IBAction)switchActivated:(id)sender {
    
    [[self.view window] makeFirstResponder:nil];
    
    if(self.switchControl.state) {
        
        [timer invalidate];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
        
        NSDate * pickerDate = [self.datePicker dateValue];
        NSInteger desiredComponents = (NSHourCalendarUnit | NSMinuteCalendarUnit);
        NSDateComponents *dateComponents1 = [calendar components:desiredComponents fromDate:pickerDate];
        [components setHour:[dateComponents1 hour]];
        [components setMinute:[dateComponents1 minute]];
        
        NSDate *todayPickerTime = [calendar dateFromComponents:components];
        
        
            
        NSComparisonResult result = [todayPickerTime compare:[NSDate date]];
        if (result == NSOrderedAscending) {
                NSLog(@"+day!");
                todayPickerTime = [todayPickerTime dateByAddingTimeInterval:60*60*24*1];
        }
            
        timer = [NSTimer scheduledTimerWithTimeInterval:1000
                                                     target:self
                                                   selector:@selector(timerTick:)
                                                   userInfo:nil
                                                    repeats:NO];
        [timer setFireDate:todayPickerTime];
    
    } else {
        [timer invalidate];
    }
}

-(void)timerTick:(id)sender {
    [self.switchControl setState:0];
    [self.delegate fireAlarmWithNote:[self.noteField stringValue]];
    [timer invalidate];
        timer=nil;
}

@end
