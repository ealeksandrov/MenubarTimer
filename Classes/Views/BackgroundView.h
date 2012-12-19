//
//  BackgroundView.h
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 18.12.12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

#define ARROW_WIDTH 12
#define ARROW_HEIGHT 8

@interface BackgroundView : NSView
{
    NSInteger _arrowX;
}

@property (nonatomic, assign) NSInteger arrowX;

@end
