//
//  LCAppDelegate.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <objc/runtime.h>
#import "LCAppDelegate.h"
#import "LCMapController.h"
#import "LCUser.h"

@implementation LCAppDelegate

@synthesize window = _window, navigationBar;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    LCMapController *map = [[LCMapController alloc] initWithNibName:@"LCMapController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:map];
    
    object_setClass(nav.navigationBar, [LCNavigationBar class]);
    self.navigationBar = (LCNavigationBar *)nav.navigationBar;
    
    [self loadCurrentUser];
    
    self.window.rootViewController = nav;
    
    return YES;
}

- (void)loadCurrentUser {
    LCUser *user1 = [[LCUser alloc] init];
    user1.name = @"vojto";
    user1.level = [NSNumber numberWithInt:4];
    user1.email = @"vojto@rinik.net";
    user1.experience = [NSNumber numberWithInt:1000];
    user1.distance = [NSNumber numberWithInt:0];
    
    self.navigationBar.user = user1;
    [self.navigationBar layoutSubviews];
    
    NSLog(@"%@", self.navigationBar);
}

@end
