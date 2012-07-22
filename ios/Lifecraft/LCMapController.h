//
//  LCMapController.h
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LCQuestController.h"
#import "LCNavigationBar.h"
#import "LCUser.h"

@interface LCMapController : UIViewController <CLLocationManagerDelegate>

@property (strong) CLLocationManager *locationManager;
@property (strong) CLLocation *lastLocation;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *overlay;

@property (strong) NSArray *quests;

@property (strong) NSArray *users;

@property (strong) LCQuestController *questController;

@property (strong) LCNavigationBar *bar;


- (void)setupMap;
// Shows current user's avatar
- (void)login:(LCUser *)user;
- (void)setupCurrentUser;

#pragma mark - Displaying helpers
- (void)positionView:(UIView *)view byDistance:(NSInteger)distance;

#pragma mark - Quests
- (void)loadQuests;
- (void)displayQuests;
- (void)didTapQuest:(NSNotification *)notif;

#pragma mark - Users
- (void)loadUsers;
- (void)displayUsers;

@end
