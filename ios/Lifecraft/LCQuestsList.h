//
//  LCQuestsList.h
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCQuestsList : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong) NSArray *quests;

- (void)loadQuests;

- (UITableViewCell *)prepareCell:(Class)klass identifier:(NSString *)identifier tableView:(UITableView *)tableView;

@end
