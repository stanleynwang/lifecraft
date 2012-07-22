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

@synthesize quest;
@synthesize titleLabel;
@synthesize experience;
@synthesize text;

- (void)viewWillAppear:(BOOL)animated {
    self.titleLabel.text = self.quest.title;
    self.experience = [NSString stringWithFormat:@"Experience: %@", self.quest.experience];
    self.text.text = self.quest.text;
}

- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setExperience:nil];
    [self setText:nil];
    [super viewDidUnload];
}

- (IBAction)accept:(id)sender {
    NSLog(@"Accepting quest: %@", self.quest);
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                            [NSURL URLWithString:@"http://192.168.0.126:9001/"]];
    
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
@end
