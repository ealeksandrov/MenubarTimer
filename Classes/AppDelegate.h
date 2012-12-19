//
//  AppDelegate.h
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 18.12.12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

#import "MenubarController.h"
#import "PanelController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, PanelControllerDelegate>

@property (nonatomic, strong) MenubarController *menubarController;
@property (nonatomic, strong, readonly) PanelController *panelController;

- (IBAction)togglePanel:(id)sender;

@end