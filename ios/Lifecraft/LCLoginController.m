//
//  LCLoginController.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LCLoginController.h"

@interface LCLoginController ()

@end

@implementation LCLoginController
@synthesize email;

- (IBAction)logi:(id)sender {
    RNPostNotification(@"didLogin");
}


@end
