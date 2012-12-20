//
//  SettingsView.h
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 19.12.12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

@protocol SettingsDelegate<NSObject>
@required
- (void)saveSetting:(bool)showWindow;
@end

@interface SettingsView : NSWindowController <NSWindowDelegate> {
    bool selectedWindow;
}

@property (nonatomic, assign)id <SettingsDelegate> delegate;
@property (nonatomic, unsafe_unretained) IBOutlet NSMatrix *radioGroup;

-(IBAction)close:(id)sender;

-(id)initWithSetting:(bool)setting;

@end
