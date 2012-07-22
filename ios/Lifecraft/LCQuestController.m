//
//  LCQuestController.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LCQuestController.h"

@interface LCQuestController ()

@end

@implementation LCQuestController

@synthesize quest;
@synthesize titleLabel;
@synthesize experience;
@synthesize text;

- (void)viewDidLoad {
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)hide:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
