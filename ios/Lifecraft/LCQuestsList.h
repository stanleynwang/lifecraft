//
//  LCQuestsList.h
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCQuestsList : UIViewController <UITableViewDataSource, UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong) NSArray *quests;

- (UITableViewCell *)prepareCell:(Class)klass identifier:(NSString *)identifier tableView:(UITableView *)tableView;

@end
