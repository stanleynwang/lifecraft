//
//  LCQuestController.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFJSONUtilities.h>
#import "LCQuestController.h"

@interface LCQuestController ()

@end

@implementation LCQuestController
@synthesize hide;
@synthesize accept;
@synthesize finish;

@synthesize quest;
@synthesize titleLabel;
@synthesize experience;
@synthesize text;
@synthesize address;

- (void)viewWillAppear:(BOOL)animated {
    self.titleLabel.text = self.quest.title;
    self.experience.text = [NSString stringWithFormat:@"%d XP", 400];
    self.text.text = self.quest.text;
    self.address.text = self.quest.address;

    self.accept.hidden = YES;
    self.hide.hidden = YES;
    self.finish.hidden = YES;
    
    if (self.quest.isCurrent) {
        self.finish.hidden = NO;
    } else {
        self.accept.hidden = NO;
        self.hide.hidden = NO;
    }
}

- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setExperience:nil];
    [self setText:nil];
    [self setAddress:nil];
    [self setAccept:nil];
    [self setHide:nil];
    [self setFinish:nil];
    [super viewDidUnload];
}

- (IBAction)accept:(id)sender {
    NSLog(@"Accepting quest: %@", self.quest);
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                            [NSURL URLWithString:URL]];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:quest.identifier, @"activity_id", nil];
    
    [client getPath:@"/api/quest/new" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Accepting quest succeeded... %@", responseObject);
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request failed %@", error);
    }];

}

- (IBAction)hide:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)finish:(id)sender {
    NSLog(@"Finishing quest");
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                            [NSURL URLWithString:URL]];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.quest.identifier, @"id", nil];
    
    [client getPath:@"/api/quest/complete" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id data = AFJSONDecode(responseObject, nil);
        NSLog(@"Finishing quest succeeded... %@", data);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request failed %@", error);
    }];
}
@end
