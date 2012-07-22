//
//  LCUser.h
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCUser : NSObject

@property (strong) NSString *name;
@property (strong) NSString *email; // will be used for gravatar
@property (strong) NSNumber *level;
@property (strong) NSNumber *experience;
@property (strong) NSNumber *distance;

@end
