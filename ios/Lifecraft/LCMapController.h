//
//  LCMapController.h
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LCMapController : UIViewController <CLLocationManagerDelegate>

@property (strong) CLLocationManager *locationManager;
@property (strong) CLLocation *lastLocation;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *overlay;

@property (strong) NSArray *quests;


- (void)setupMap;
// Shows current user's avatar
- (void)setupCurrentUser;

- (void)loadQuests;
- (void)displayQuests;

@end
