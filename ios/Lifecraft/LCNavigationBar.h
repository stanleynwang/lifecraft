//
//  LCNavigationBar.h
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCUser.h"

@interface LCNavigationBar : UIView

@property (strong) LCUser *user;

- (void)didTapButton:(id)sender;

@end
