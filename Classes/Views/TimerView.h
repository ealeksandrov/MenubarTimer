//
//  TimerView.h
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 19.12.12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TimerView;

@protocol TimerDelegate<NSObject>
@required
- (void)deleteTimer:(TimerView *)timerInstance;
@end

@interface TimerView : NSViewController

@property (nonatomic, assign)id <TimerDelegate> delegate;

-(IBAction)deleteMe:(id)sender;

@end
