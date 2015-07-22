//
//  CoursesViewController.m
//  GuruCrafter
//
//  Created by  ZHEKA on 17.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "CoursesViewController.h"
#import "Course.h"
#import "GroupInfoController.h"
//#import "StudentsFromCourseTableViewController.h"

@interface CoursesViewController ()

@end

@implementation CoursesViewController
@synthesize fetchedResultsController = _fetchedResultsController;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Course *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", course.name];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


- (NSFetchedResultsController *)fetchedResultsController
{
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Course *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSLog(@"%@ %ld", course.name, [course.users count]);
    
    GroupInfoController *vc = [[GroupInfoController alloc] init];
    vc.course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
