//
//  LCAppDelegate.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LCAppDelegate.h"
#import "LCMapController.h"

@implementation LCAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    LCMapController *map = [[LCMapController alloc] initWithNibName:@"LCMapController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:map];
    
    self.window.rootViewController = nav;
    
    return YES;
}



@end
