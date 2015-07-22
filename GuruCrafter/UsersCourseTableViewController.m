//
//  UsersCourseTableViewController.m
//  GuruCrafter
//
//  Created by  ZHEKA on 18.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "UsersCourseTableViewController.h"
#import "UserEnabledDissableCellTableViewCell.h"

@interface UsersCourseTableViewController ()

@end

@implementation UsersCourseTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Users";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UserEnabledDissableCellTableViewCell *cell = (UserEnabledDissableCellTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.imView) {
        cell.picture = nil;
        User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.vcStudents.course removeUsersObject:user];
        [self.managedObjectContext save:nil];
    } else {
        cell.picture = [UIImage imageNamed:@"1.png"];
        User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.vcStudents.course addUsersObject:user];
        
        [self.managedObjectContext save:nil];
    }
    
    [self.tableView reloadData];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.tableView reloadData];
//    });
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserEnabledDissableCellTableViewCell *cell = [[UserEnabledDissableCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"someString"];

    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    
    if ([self.vcStudents.course.users containsObject:[self.fetchedResultsController objectAtIndexPath:indexPath]]) {
        
        ((UserEnabledDissableCellTableViewCell*)cell).picture = [UIImage imageNamed:@"1.png"];
    }

    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    
    //[fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [[DataSource sharedApplication] printAll];
    
    return _fetchedResultsController;
}



@end
