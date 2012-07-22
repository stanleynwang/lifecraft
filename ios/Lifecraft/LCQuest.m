//
//  LCQuest.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LCQuest.h"

@implementation LCQuest

@synthesize distance, title, text, location, experience, identifier;

+ (NSArray *)questsFromResponse:(NSArray *)data {
    NSMutableArray *quests = [NSMutableArray array];
    
    for (NSDictionary *item in data) {
        LCQuest *quest = [[LCQuest alloc] init];
        
        NSNumber *distance = [item objectForKey:@"distance"];
        CGFloat dist = distance.floatValue;
        dist *= 100; // 1 mile = 100, 100 is the max
        
        quest.distance = [NSNumber numberWithFloat:dist];
        
        
        
        quest.title = [item objectForKey:@"name"];
        quest.experience = [NSNumber numberWithInt:500]; // TODO: Actual experience
        
        CGFloat lati = ((NSNumber *)[item objectForKey:@"latitude"]).floatValue;
        CGFloat longi = ((NSNumber *)[item objectForKey:@"longitude"]).floatValue;
        
        quest.location = [[CLLocation alloc] initWithLatitude:lati
    longitude:longi];
        
        quest.text = [item objectForKey:@"description"];
        
        quest.identifier = [NSString stringWithFormat:@"%@", [item objectForKey:@"id"]];
        
        [quests addObject:quest];
    }
    
    return quests;
}

@end
