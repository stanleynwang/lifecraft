//
//  LCQuestView.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LCQuestView.h"

@implementation LCQuestView

@synthesize quest, isFarAway;

- (id)initWithFrame:(CGRect)frame {
    frame.size = CGSizeMake(50, 80);
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 15, 50, 50)];
    [button setImage:[UIImage imageNamed:@"Quest.png"] forState:UIControlStateNormal];    
    [self addSubview:button];
    [button addTarget:self action:@selector(didTap:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, 50, 30)];

    label.text = quest.title;
    label.numberOfLines = 2;
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    
    label.font = [UIFont boldSystemFontOfSize:10];
    label.textColor = [UIColor colorWithRed:0.196 green:0.231 blue:0.275 alpha:1.];

    
    CGRect rect = label.frame;
    label.frame = rect;
    
    [self addSubview:label];
    
    if (self.isFarAway) {
        UIImageView *far = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QuestArrow.png"]];
        CGRect frame = far.frame;
        frame.origin = CGPointMake(17, 0);
        far.frame = frame;
        [self addSubview:far];
    }
}

- (void)setFarAway {
    self.isFarAway = YES;
}

- (void)didTap:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"QuestButtonTap" object:self.quest]];
}

@end
