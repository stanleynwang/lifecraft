//
//  LCQuestView.h
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCQuest.h"

@interface LCQuestView : UIView

@property (strong) LCQuest *quest;
@property (assign) BOOL isFarAway;

- (void)setFarAway;

@end
