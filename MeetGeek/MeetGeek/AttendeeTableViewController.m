//
//  AttendeeTableViewController.m
//  MeetGeek
//
//  Created by Julianne on 10/24/16.
//  Copyright © 2016 Julianne Goyena. All rights reserved.
//

#import "AttendeeTableViewController.h"
#import "Attendee.h"
#import "FirebaseManager.h"

@implementation AttendeeTableViewController

static NSString *const reuseIdentifier = @"AttendeeCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    [[FirebaseManager sharedManager] setDelegate:self];
}

-(void)reloadRequests{

    [self.tableView reloadData];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Want to change to number of attendees
    return [[self attendees]count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];

    // Configure the cell...
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    Attendee *attendee = [self attendees][indexPath.row];
    cell.textLabel.text = attendee.event.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@ %@ \"%@\"", attendee.name, attendee.age, attendee.sex, attendee.comment];
    return cell;
}

-(NSArray <Attendee*> *)attendees {

    return [[[FirebaseManager sharedManager]attendees]copy];
}
@end
