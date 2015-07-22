//
//  UsersTableViewController.m
//  GuruCrafter
//
//  Created by  ZHEKA on 16.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "UsersTableViewController.h"
#import "User.h"
#import "UserInfoController.h"

@interface UsersTableViewController () <NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation UsersTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Users";
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newUser:)];
    self.navigationItem.rightBarButtonItem = button;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions -

- (void) newUser : (UIBarButtonItem*) sender {
    
    UserInfoController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"UserInfoController"];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nc animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UserInfoController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"UserInfoController"];
    
    vc.user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nc animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
   User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    
    
       [fetchRequest setFetchBatchSize:20];
    
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
