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
        // Initialization code here.
    }
    
    return self;
}

-(IBAction)deleteMe:(id)sender {
    [self.delegate deleteTimer:self];
}

@end
