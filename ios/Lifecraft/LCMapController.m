//
//  LCMapController.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LCMapController.h"
#import <AFNetworking/AFNetworking.h>
#import <QuartzCore/QuartzCore.h>

@interface LCMapController ()

@end

@implementation LCMapController
@synthesize mapView;
@synthesize overlay;

@synthesize locationManager, lastLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupMap];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCurrentUser];
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
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(135, 310, 50, 50)];
    avatar.backgroundColor = [UIColor redColor];
    UIImage *placeholder = [UIImage imageNamed:@"placeholder.jpg"];
//    avatar.image = placeholder;
    [avatar setImageWithURL:[NSURL URLWithString:@"http://www.gravatar.com/avatar/1740f056b79158cc9c8c287bb32573e5"] placeholderImage:placeholder];

    [self.overlay addSubview:avatar];
    
    CALayer* maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(0,0, 50, 50);
    maskLayer.contents = (__bridge id)[[UIImage imageNamed:@"Mask.png"] CGImage];
    
    // Apply the mask to your uiview layer
    avatar.layer.mask = maskLayer;
    
//    avatar.layer.shadowColor = [UIColor blackColor].CGColor;
//    avatar.layer.shadowOffset = CGSizeMake(5.0, 5.0);
//    avatar.layer.shadowRadius = 3.0;
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


- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setOverlay:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
