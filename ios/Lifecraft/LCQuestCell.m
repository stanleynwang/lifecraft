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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(36, 6, 220, 20)];
        self.title.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
        //        self.title.font = [UIFont systemFontOfSize:16];
        self.title.textColor = [UIColor colorWithRed:0.153 green:0.184 blue:0.204 alpha:1.];
        self.title.shadowColor = [UIColor colorWithWhite:1 alpha:0.5];
        self.title.shadowOffset = CGSizeMake(0, 1);
        self.title.backgroundColor = [UIColor clearColor];
        [self addSubview:self.title];
        
        self.subtitle1 = [[UILabel alloc] initWithFrame:CGRectMake(36, 23, 60, 20)];
        //        self.tariff.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:11];
        self.subtitle1.font = [UIFont boldSystemFontOfSize:11];
        self.subtitle1.textColor = [UIColor colorWithRed:0.294 green:0.557 blue:0.647 alpha:1.];
        self.subtitle1.shadowColor = [UIColor colorWithWhite:1 alpha:0.5];
        self.subtitle1.shadowOffset = CGSizeMake(0, 1);
        self.subtitle1.backgroundColor = [UIColor clearColor];
        [self addSubview:self.subtitle1];
        
        self.subtitle2 = [[UILabel alloc] initWithFrame:CGRectMake(93, 23, 150, 20)];
        //        self.date.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:11];
        self.subtitle2.font = [UIFont boldSystemFontOfSize:11];
        self.subtitle2.textColor = [UIColor colorWithRed:0.082 green:0.369 blue:0.471 alpha:1.];
        self.subtitle2.shadowColor = [UIColor colorWithWhite:1 alpha:0.5];
        self.subtitle2.shadowOffset = CGSizeMake(0, 1);
        self.subtitle2.backgroundColor = [UIColor clearColor];
        [self addSubview:self.subtitle2];
        
        self.secondaryTitle = [[UILabel alloc] initWithFrame:CGRectMake(230, 6, 85, 20)];
        //        self.price.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:11];
        self.secondaryTitle.font = [UIFont boldSystemFontOfSize:18];
        self.secondaryTitle.textAlignment = UITextAlignmentRight;
        self.secondaryTitle.textColor = [UIColor colorWithRed:0.133 green:0.180 blue:0.188 alpha:1.];
        self.secondaryTitle.shadowColor = [UIColor colorWithWhite:1 alpha:0.5];
        self.secondaryTitle.shadowOffset = CGSizeMake(0, 1);
        self.secondaryTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:self.secondaryTitle];
        
        self.secondarySubtitle = [[UILabel alloc] initWithFrame:CGRectMake(215, 23, 100, 20)];
        //        self.time.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:11];
        self.secondarySubtitle.font = [UIFont boldSystemFontOfSize:11];
        self.secondarySubtitle.textAlignment = UITextAlignmentRight;
        self.secondarySubtitle.textColor = [UIColor colorWithRed:0.314 green:0.380 blue:0.369 alpha:1.];
        self.secondarySubtitle.shadowColor = [UIColor colorWithWhite:1 alpha:0.5];
        self.secondarySubtitle.shadowOffset = CGSizeMake(0, 1);
        self.secondarySubtitle.backgroundColor = [UIColor clearColor];
        [self addSubview:self.secondarySubtitle];
    }
    return self;
}

- (void)update {
    self.title.text = self.quest.title;
}

@end
