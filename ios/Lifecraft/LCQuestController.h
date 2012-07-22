//
//  LCQuestController.h
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCQuest.h"

@interface LCQuestController : UIViewController

@property (strong) LCQuest *quest;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *experience;
@property (weak, nonatomic) IBOutlet UITextView *text;
@property (weak, nonatomic) IBOutlet UILabel *address;
- (IBAction)accept:(id)sender;
- (IBAction)hide:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *hide;
@property (weak, nonatomic) IBOutlet UIButton *accept;
@property (weak, nonatomic) IBOutlet UIButton *finish;
- (IBAction)finish:(id)sender;

@end
