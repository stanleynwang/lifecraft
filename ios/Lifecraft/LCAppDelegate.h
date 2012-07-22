//
//  LCAppDelegate.h
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCNavigationBar.h"
#import "LCQuestsList.h"

@interface LCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong) UINavigationController *navigationController;
@property (strong) LCQuestsList *questsList;

- (void)loadCurrentUser;
- (void)didTapQuestsButton:(NSNotification *)notif;

@end
