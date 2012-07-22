//
//  LCAppDelegate.h
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCNavigationBar.h"

@interface LCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong) LCNavigationBar *navigationBar;

- (void)loadCurrentUser;

@end
