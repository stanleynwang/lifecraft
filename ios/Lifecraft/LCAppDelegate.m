//
//  LCAppDelegate.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <objc/runtime.h>
#import "LCAppDelegate.h"
#import "LCUser.h"
#import "LCLoginController.h"

@implementation LCAppDelegate

@synthesize window = _window, navigationController, questsList, map;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    LCLoginController *login = [[LCLoginController alloc] initWithNibName:@"LCLoginController" bundle:nil];
    self.map = [[LCMapController alloc] initWithNibName:@"LCMapController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    
    self.navigationController = nav;
    
    
    self.window.rootViewController = nav;
    
    RNObserveNotification(@"didTapQuestsButton", @selector(didTapQuestsButton:));
    RNObserveNotification(@"didLogin", @selector(didLogin:));
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Bar"] forBarMetrics:UIBarMetricsDefault];
    UIImage *button = [[UIImage imageNamed:@"Button"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [[UIBarButtonItem appearance] setBackgroundImage:button forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    return YES;
}

- (void)didTapQuestsButton:(NSNotification *)notif {
    if (!self.questsList) {
        self.questsList = [[LCQuestsList alloc] initWithNibName:@"LCQuestsList" bundle:nil];
    }
    if ([self.navigationController.viewControllers lastObject] == self.questsList) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController pushViewController:self.questsList animated:YES];
    }
}

- (void)didLogin:(NSNotification *)notif {
    [self.navigationController pushViewController:self.map animated:YES];
    [self.map login:(LCUser *)notif.object];
}

@end
