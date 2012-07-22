//
//  LCDataContext.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LCDataContext.h"

static LCDataContext *sharedSingleton;

@implementation LCDataContext

+ (LCDataContext *)instance
{
    static LCDataContext *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[LCDataContext alloc] init];
        
        return sharedSingleton;
    }
}


@end
