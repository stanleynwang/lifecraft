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
#import <AFNetworking/AFJSONUtilities.h>
#import "LCQuest.h"
#import "LCQuestView.h"
#import "LCUser.h"
#import "LCUserView.h"
#import "LCNavigationBar.h"

static int _x_v;

@interface LCMapController ()

@end

@implementation LCMapController
@synthesize mapView;
@synthesize overlay;

@synthesize locationManager, lastLocation, quests, users, questController, questViews;
@synthesize bar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupMap];
        
        RNObserveNotification(@"QuestButtonTap", @selector(didTapQuest:));
        RNObserveNotification(@"QuestList.didSelectQuest", @selector(didTapQuest:));
        
        self.bar = [[LCNavigationBar alloc] initWithFrame:CGRectMake(0, 371, 320, 80)];
        self.questViews = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.overlay addSubview:self.bar];
}

- (void)viewWillAppear:(BOOL)animated {
    _x_v = 0;
    [self loadQuests];
    [self loadUser];
    [self showLastLocation];
}

- (void)viewDidAppear:(BOOL)animated {
    [self showLastLocation];
}

- (void)setupMap {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 50;
    [self.locationManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
}

- (void)login:(LCUser *)user {
    NSLog(@"Logged in as %@", user);
    
    NSLog(@"self.bar = %@", self.bar);
    NSLog(@"self.overla = %@", self.overlay);
    
    self.bar.user = user;
    [self.bar layoutSubviews];
    
    LCUserView *view = [[LCUserView alloc] initWithFrame:CGRectMake(135, 305, 50, 50)];
    view.user = user;
    [self.overlay addSubview:view];
    
}

- (void)didLogin:(NSNotification *)notif {
    
    /*
     
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
     
     */
}

- (void)setupCurrentUser {
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"Location manager updated to location: %@", newLocation);

    // Store the location
    
    self.lastLocation = newLocation;
    
    // Zoom there
    
    [self showLastLocation];
}

- (void)showLastLocation {
    MKMapPoint point = MKMapPointForCoordinate(self.lastLocation.coordinate);
    point.x -= 5000;
    point.y -= 9000;
    MKMapRect rect = MKMapRectMake(point.x, point.y, 10000, 10000);
    [self.mapView setVisibleMapRect:rect animated:YES];
    self.mapView.showsUserLocation = YES;
}

#pragma mark - Helpers
- (void)positionView:(UIView *)view byDistance:(NSInteger)distance {
    if (distance > 100) {
        distance = 100;
        [view performSelector:@selector(setFarAway)];
    }
    
    CGFloat x = (_x_v++) * 60 + 5;
    if (_x_v > 4) _x_v = 0;
    CGFloat y = (100-distance) * 2.2 + 5;
    
    NSLog(@"%f %f", x, y);
    
    
    CGRect frame = view.frame;
    frame.origin = CGPointMake(x, y);
    view.frame = frame;
}

#pragma mark - Loading quests

- (void)loadQuests {
    // Stub some quests
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                            [NSURL URLWithString:URL]];

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YY-MM-dd"];
    NSString *date = [format stringFromDate:[NSDate date]];
    NSString *path = [NSString stringWithFormat:@"/api/activity/find/%@", date];
    
    CGFloat lati = self.lastLocation.coordinate.latitude;
    CGFloat longi = self.lastLocation.coordinate.longitude;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:lati], @"lat",
                            [NSNumber numberWithFloat:longi], @"long", nil];
    
    NSLog(@"%@ %@", path, params);
        
    [client getPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *data = AFJSONDecode(responseObject, nil);
        self.quests = [LCQuest questsFromResponse:data];
        NSLog(@"Request finished: %@", data);
        
        [self displayQuests];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request failed %@", error);
    }];
    
}

- (void)displayQuests {
    for (UIView *view in self.questViews) {
        [view removeFromSuperview];
    }
    [self.questViews removeAllObjects];
    
    for (LCQuest *quest in self.quests) {
        LCQuestView *view = [[LCQuestView alloc] initWithFrame:CGRectZero];
        view.quest = quest;
        [self positionView:view byDistance:quest.distance.integerValue];
        [self.overlay addSubview:view];
        [self.questViews addObject:view];
    }
}

- (void)didTapQuest:(NSNotification *)notif {
    LCQuest *quest = (LCQuest *)notif.object;
    NSLog(@"Tapped quest %@", quest.title);
    
    if (!self.questController) {
        self.questController = [[LCQuestController alloc] initWithNibName:@"LCQuestController" bundle:nil];
    }
    
    self.questController.quest = quest;
    [self.navigationController pushViewController:self.questController animated:YES];
}

/*************************************************/
#pragma mark - Users
/*************************************************/

- (void)loadUsers {
    LCUser *user1 = [[LCUser alloc] init];
    user1.name = @"kourge";
    user1.level = [NSNumber numberWithInt:4];
    user1.email = @"kourge@gmail.com";
    user1.experience = [NSNumber numberWithInt:1000];
    user1.distance = [NSNumber numberWithInt:0];
    
    LCUser *user2 = [[LCUser alloc] init];
    user2.name = @"Mahhh";
    user2.level = [NSNumber numberWithInt:3];
    user2.email = @"mahhaha@gmail.com";
    user2.experience = [NSNumber numberWithInt:700];
    user2.distance = [NSNumber numberWithInt:100];
    
    self.users = [NSArray arrayWithObjects:user1, user2, nil];
    [self displayUsers];
}

- (void)loadUser {
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                            [NSURL URLWithString:URL]];
    
    [client getPath:@"/api/users/current_user" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *data = AFJSONDecode(responseObject, nil);
        LCUser *user = [LCUser userFromData:data];
        
        NSInteger previousLevel = self.bar.user.level.intValue;
        NSInteger currentLevel = user.level.intValue;
        
        self.bar.user = user;
        [self.bar layoutSubviews];
        
        NSLog(@"Comparing levels %d <> %d", previousLevel, currentLevel);
        
        if (previousLevel && currentLevel > previousLevel) {
            NSLog(@"Ding!");
            [self ding];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];

}

- (void)displayUsers {
    for (LCUser *user in self.users) {
        LCUserView *view = [[LCUserView alloc] initWithFrame:CGRectZero];
        view.user = user;
        [self positionView:view byDistance:user.distance.integerValue];
        [self.overlay addSubview:view];
    }
}

- (void)ding {
    [self performSelector:@selector(displayDing) withObject:nil afterDelay:0.5];
}

- (void)displayDing {
    UIImage *image = [UIImage imageNamed:@"Ding"];
    UIImageView *view = [[UIImageView alloc] initWithImage:image];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 190, 190)];
    label.text = [NSString stringWithFormat:@"%@", self.bar.user.level];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:150];
    label.textColor = [UIColor colorWithRed:1.000 green:0.886 blue:0.247 alpha:1.];
    label.textAlignment = UITextAlignmentCenter;
    [view addSubview:label];

    CGRect frame = view.frame;
    frame.origin = CGPointMake(55, 50);
    view.frame = frame;

    [self.overlay addSubview:view];

    view.transform = CGAffineTransformMakeScale(0.5, 0.5);

    // YO DAWG...
    [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
        view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:0.0 options:0 animations:^{
            CGAffineTransform t = CGAffineTransformMakeTranslation(-113, 252);
            t = CGAffineTransformScale(t, 0.15, 0.15);
            view.transform = t;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:0.0 options:0 animations:^{
                view.alpha = 0.0;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
            }];
        }];
    }];
}


@end
