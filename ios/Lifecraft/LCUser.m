//
//  LCUser.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LCUser.h"

@implementation LCUser

@synthesize name, email, level, experience, distance;

+ (LCUser *)userFromData:(NSDictionary *)data {
    LCUser *user = [[LCUser alloc] init];
    user.name = [data objectForKey:@"nickname"];
    user.email = [data objectForKey:@"email"];
    user.level = [data objectForKey:@"level"];
    user.experience = [data objectForKey:@"experience"];
    return user;
}

@end
