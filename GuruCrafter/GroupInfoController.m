//
//  GroupInfoController.m
//  GuruCrafter
//
//  Created by  ZHEKA on 20.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "GroupInfoController.h"
#import "User.h"
#import "CheckedUsers.h"

@interface GroupInfoController ()

@end

@implementation GroupInfoController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.course.users count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *addKey = @"Add key";
    static NSString *someCell = @"SomeCell";
    
    UITableViewCell *cell;
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        cell = [self.tableView dequeueReusableCellWithIdentifier:addKey];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addKey];
            [self configureCell:cell atIndexPath:indexPath];
        }
        
    } else {
        
        cell = [self.tableView dequeueReusableCellWithIdentifier:someCell];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:someCell];
            [self configureCell:cell atIndexPath:indexPath];
        }
        
    }
    
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    return YES;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        indexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
        
        CheckedUsers *vc = [[CheckedUsers alloc] initWithCourse:self.course];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
}


#pragma mark - NSFetchedResultsControllerDelegate -



- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    sectionIndex = sectionIndex - 1;
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    indexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
    newIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row + 1 inSection:newIndexPath.section];
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
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
    
    
    NSSortDescriptor *sortFirstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor *sortLastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    
    NSArray *sortDescriptors = @[sortFirstNameDescriptor, sortLastNameDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSPredicate *userPredicate = [NSPredicate predicateWithFormat:@"courses CONTAINS %@", self.course];
    [fetchRequest setPredicate:userPredicate];
    
    
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


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"Add new student";
        
        label.frame = CGRectMake(cell.bounds.size.width / 2 - 35, cell.bounds.size.height / 2 - 20, 140, 40);
        
        [cell addSubview:label];
        
        return;
    }
    
    indexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:0];
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    indexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:0];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.course removeUsersObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
    }
}




@end
