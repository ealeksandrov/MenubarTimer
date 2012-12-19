//
//  AlertView.h
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 12/19/12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

@interface AlertView : NSWindowController {
    NSString *_note;
}

-(id)initWithMessage:(NSString *)note;

@end
