//
//  LCMapController.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LCMapController.h"

@interface LCMapController ()

@end

@implementation LCMapController
@synthesize mapView;

@synthesize locationManager, lastLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupMap];
        [self setupCurrentUser];
    }
    return self;
}

- (void)setupMap {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 50;
    [self.locationManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
}

- (void)setupCurrentUser {
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"Location manager updated to location: %@", newLocation);

    // Store the location
    
    self.lastLocation = newLocation;
    
    // Zoom there
    
    MKMapPoint point = MKMapPointForCoordinate(newLocation.coordinate);
    point.x -= 5000;
    point.y -= 9000;
    MKMapRect rect = MKMapRectMake(point.x, point.y, 10000, 10000);
    [self.mapView setVisibleMapRect:rect animated:YES];
    self.mapView.showsUserLocation = YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
