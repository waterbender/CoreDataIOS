//
//  CheckedUsers.m
//  GuruCrafter
//
//  Created by  ZHEKA on 20.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "CheckedUsers.h"
#import "UserEnabledDissableCellTableViewCell.h"

@interface CheckedUsers ()

@end

@implementation CheckedUsers
@synthesize fetchedResultsController = _fetchedResultsController;


- (instancetype)initWithCourse : (Course*) course
{
    self = [super init];
    if (self) {
        self.course = course;
    }
    return self;
}

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

#pragma mark - UITableViewDelegate -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];

    if ([self.course.users containsObject:user]) {

        [self.course removeUsersObject:user];
    } else {

        [self.course addUsersObject:user];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
        
        [self.tableView reloadData];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *checkedCell = @"SomeCell";
    
    UserEnabledDissableCellTableViewCell *cell = [[UserEnabledDissableCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:checkedCell];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if ([self.course.users containsObject:user]) {
        ((UserEnabledDissableCellTableViewCell*)cell).picture = [UIImage imageNamed:@"1.png"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat: @"%@ %@", user.firstName, user.lastName];
    
}


#pragma - NSFetchedResultsControllerDelegate

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
    
    
    NSSortDescriptor *sortFirstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor *sortLastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    
    NSArray *sortDescriptors = @[sortFirstNameDescriptor, sortLastNameDescriptor];
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
