//
//  MenubarController.h
//  MenubarTimer
//
//  Created by Evgeny Aleksandrov on 18.12.12.
//  Copyright (c) 2012 TestTask. All rights reserved.
//

#define STATUS_ITEM_VIEW_WIDTH 24.0

#pragma mark -

@class StatusItemView;

@interface MenubarController : NSObject

@property (nonatomic) BOOL hasActiveIcon;
@property (nonatomic, strong, readonly) NSStatusItem *statusItem;
@property (nonatomic, strong, readonly) StatusItemView *statusItemView;

@end
