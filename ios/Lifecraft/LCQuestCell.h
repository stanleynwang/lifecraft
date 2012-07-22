//
//  LCQuestCell.h
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCQuest.h"

@interface LCQuestCell : UITableViewCell

@property (strong) LCQuest *quest;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *subtitle1;
@property (nonatomic, strong) UILabel *subtitle2;
@property (nonatomic, strong) UILabel *secondaryTitle;
@property (nonatomic, strong) UILabel *secondarySubtitle;

- (void)update;

@end
