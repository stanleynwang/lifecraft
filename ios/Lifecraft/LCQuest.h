//
//  LCQuest.h
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface LCQuest : NSObject

@property (strong) NSNumber *distance;
@property (strong) NSString *title;
@property (strong) NSString *text;
@property (strong) CLLocation *location;
@property (strong) NSNumber *experience;

@end
