//
//  AlertView.h
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 12/19/12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

@interface AlertView : NSWindowController <NSWindowDelegate> {
    NSString *_note;
}

@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *noteField;

-(id)initWithMessage:(NSString *)note;

-(IBAction)close:(id)sender;

@end
