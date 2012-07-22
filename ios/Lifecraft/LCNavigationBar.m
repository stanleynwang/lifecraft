//
//  LCNavigationBar.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LCNavigationBar.h"
#import "LCUserView.h"

@implementation LCNavigationBar

@synthesize user;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {
    NSLog(@"Laying out");
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BottomBar.png"]];
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (self.user) {
        LCUserView *view = [[LCUserView alloc] initWithFrame:CGRectMake(5, 4, 35, 35)];
        view.user = self.user;
        [self addSubview:view];
    }
    
    UIView *level = [[UIView alloc] initWithFrame:CGRectMake(30, 20, 21, 21)];
    level.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Level.png"]];
    UILabel *levLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    levLab.backgroundColor = [UIColor clearColor];
    levLab.text = [NSString stringWithFormat:@"%@", self.user.level];
    levLab.font = [UIFont boldSystemFontOfSize:11];
    levLab.textAlignment = UITextAlignmentCenter;
    levLab.textColor = [UIColor whiteColor];
    levLab.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
    levLab.shadowOffset = CGSizeMake(0, 1);
    [level addSubview:levLab];
    
    [self addSubview:level];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(225, 5, 90, 36)];
    [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"BarButton.png"] forState:UIControlStateNormal];
    [button setTitle:@"Quests" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:button];
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    view.backgroundColor = [UIColor redColor];
//    [self addSubview:view];
}

- (void)didTapButton:(id)sender {
    RNPostNotification(@"didTapQuestsButton");
}

@end
