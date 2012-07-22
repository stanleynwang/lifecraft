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
#import "LCQuest.h"
#import "LCQuestView.h"

@interface LCMapController ()

@end

@implementation LCMapController
@synthesize mapView;
@synthesize overlay;

@synthesize locationManager, lastLocation, quests;

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
    [self loadQuests];
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
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(135, 305, 50, 50)];
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


#pragma mark - Loading quests

- (void)loadQuests {
    // Stub some quests
    LCQuest *quest1 = [[LCQuest alloc] init];
    quest1.distance = [NSNumber numberWithInt:5];
    quest1.title = @"Greylock Hackfest";
    quest1.text = @"Come spend the weekend at Dropbox HQ hacking on your own projects!";
    quest1.location = [[CLLocation alloc] initWithLatitude:37.776154 longitude:-122.393136];
    quest1.experience = [NSNumber numberWithInt:200];
    
    LCQuest *quest2 = [[LCQuest alloc] init];
    quest2.distance = [NSNumber numberWithInt:300];
    quest2.title = @"Visit Alcatraz";
    quest2.text = @"Trip to Alcatraz for $30.";
    quest2.location = [[CLLocation alloc] initWithLatitude:37.0625 longitude:-95.677068];
    quest2.experience = [NSNumber numberWithInt:200];
    
    self.quests = [NSArray arrayWithObjects:quest1, quest2, nil];
    
    [self displayQuests];
}

- (void)displayQuests {
    CGFloat maxY = 300;
    NSInteger maxX = 320;
    
    for (LCQuest *quest in self.quests) {
        // Create a view for this quest
        
        // Random X
        CGFloat x = (arc4random() % (maxX-10)) - 20;
        // Y based on distance
        NSInteger distance = quest.distance.integerValue;
        BOOL isFarAway = NO;
        if (distance > 78) {
            distance = 78;
            isFarAway = YES;
        }
        
        NSLog(@"Distance: %d", distance);
        CGFloat y = maxY - (((CGFloat)distance)/100 * maxY) - 50;
        NSLog(@"%f %f", x, y);
        
        LCQuestView *view = [[LCQuestView alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
        view.quest = quest;
        
        if (isFarAway) {
            view.isFarAway = YES;
        }
        
        [self.overlay addSubview:view];
    }
}


@end
