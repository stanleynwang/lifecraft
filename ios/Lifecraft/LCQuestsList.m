//
//  LCQuestsList.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LCQuestsList.h"
#import "LCQuest.h"
#import "LCQuestCell.h"

@interface LCQuestsList ()

@end

@implementation LCQuestsList

@synthesize tableView;
@synthesize quests;

- (void)viewDidLoad {
    UIImage *image = [UIImage imageNamed:@"Background.png"];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:image];
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadQuests];
    
//    LCQuest *quest1 = [[LCQuest alloc] init];
//    quest1.distance = [NSNumber numberWithInt:5];
//    quest1.title = @"Greylock Hackfest";
//    quest1.text = @"Come spend the weekend at Dropbox HQ hacking on your own projects!";
//    quest1.location = [[CLLocation alloc] initWithLatitude:37.776154 longitude:-122.393136];
//    quest1.experience = [NSNumber numberWithInt:200];
//    
//    LCQuest *quest2 = [[LCQuest alloc] init];
//    quest2.distance = [NSNumber numberWithInt:300];
//    quest2.title = @"Visit Alcatraz";
//    quest2.text = @"Trip to Alcatraz for $30.";
//    quest2.location = [[CLLocation alloc] initWithLatitude:37.0625 longitude:-95.677068];
//    quest2.experience = [NSNumber numberWithInt:200];
//    
//    self.quests = [NSArray arrayWithObjects:quest1, quest2, nil];
}

- (void)loadQuests {
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                            [NSURL URLWithString:URL]];
    
    [client getPath:@"/api/quest/current" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id data = AFJSONDecode(responseObject, nil);
        self.quests = [LCQuest questsFromResponse:data];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request failed %@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.quests count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCQuestCell *cell = (LCQuestCell *)[self prepareCell:[LCQuestCell class] identifier:@"LCQuestCell" tableView:self.tableView];
    
    cell.quest = [self.quests objectAtIndex:indexPath.row];
    [cell update];
    
    return cell;
}


- (UITableViewCell *)prepareCell:(Class)klass identifier:(NSString *)identifier tableView:(UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[klass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LCQuest *quest = [self.quests objectAtIndex:indexPath.row];
    RNPostNotificationWithObject(@"QuestList.didSelectQuest", quest);
}


@end
