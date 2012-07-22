//
//  LCLoginController.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFJSONUtilities.h>
#import "LCLoginController.h"
#import "LCUser.h"

@interface LCLoginController ()

@end

@implementation LCLoginController
@synthesize email = _email;

- (IBAction)logi:(id)sender {
    
    NSString *email = self.email.text;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            email, @"email",
                            nil];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                            [NSURL URLWithString:URL]];
    
    [client postPath:@"/api/login" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *data = AFJSONDecode(responseObject, nil);
        LCUser *user = [[LCUser alloc] init];
        user.name = [data objectForKey:@"nickname"];
        user.email = [data objectForKey:@"email"];
        user.level = [data objectForKey:@"level"];
        user.experience = [data objectForKey:@"experience"];
        NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Response: %@", text);
        RNPostNotificationWithObject(@"didLogin", user);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    self.email.text = @"vojto@rinik.net";
}


@end
