//
//  LCQuestCell.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LCQuestCell.h"

@implementation LCQuestCell

@synthesize title = _title, subtitle1 = _tariff, subtitle2 = _date;
@synthesize secondaryTitle = _price, secondarySubtitle = _time;
@synthesize quest;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        UIImage *image = [UIImage imageNamed:@"CellBackground.png"];
        self.backgroundView = [[UIImageView alloc] initWithImage:image];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(60, 6, 220, 20)];
        self.title.font = [UIFont boldSystemFontOfSize:16];
        //        self.title.font = [UIFont systemFontOfSize:16];
        self.title.textColor = [UIColor whiteColor];
        self.title.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.title.shadowOffset = CGSizeMake(0, 1);
        self.title.backgroundColor = [UIColor clearColor];
        [self addSubview:self.title];
        
        self.subtitle1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 23, 200, 40)];
        self.subtitle1.numberOfLines = 2;
        self.subtitle1.font = [UIFont boldSystemFontOfSize:11];
        self.subtitle1.textColor = [UIColor colorWithRed:0.816 green:0.816 blue:0.816 alpha:1.];
        self.subtitle1.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.subtitle1.shadowOffset = CGSizeMake(0, 1);
        self.subtitle1.backgroundColor = [UIColor clearColor];
        [self addSubview:self.subtitle1];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QuestFinish"]];
        CGRect frame = imageView.frame;
        frame.origin = CGPointMake(5, 5);
        imageView.frame = frame;
        [self addSubview:imageView];
    }
    return self;
}

- (void)update {
    self.title.text = self.quest.title;
    self.subtitle1.text = self.quest.text;
}

@end
