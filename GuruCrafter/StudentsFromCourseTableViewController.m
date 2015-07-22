//
//  CourseTableViewController.m
//  GuruCrafter
//
//  Created by  ZHEKA on 17.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "StudentsFromCourseTableViewController.h"
#import "InfoViewCell.h"
#import "UsersCourseTableViewController.h"

@interface StudentsFromCourseTableViewController ()

@end

@implementation StudentsFromCourseTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (instancetype)init
{
    self = [self initWithStyle:UITableViewStylePlain];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return @"Info";
    } else if (section == 1) {
        return @"Users";
    }
    
    return nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count]+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count;
    
    if (section == 0) {
        count = 5;
    } else {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section-1];
        count = [sectionInfo numberOfObjects] + 1;
    }
    
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 ) {
        
        static NSString *identifier = @"Identifier";
        
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        
        
        if (indexPath.row == 0) {
            
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Hello"];
            
            CGRect rect = cell.frame;
            rect.size.width = rect.size.width / 2;
            rect.size.height = rect.size.height - rect.size.height / 5;
            rect.origin = CGPointMake(cell.center.x - rect.size.width / 4, cell.center.y - 17);
            
            UILabel *label = [[UILabel alloc] initWithFrame:rect];
            //label.center = cell.center;
            label.text = @"Add new student";
            
            [cell addSubview:label];
            
            return cell;
        }
        
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        
        indexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 1];
        [self configureCell:cell atIndexPath:indexPath];
        
        return cell; } else if (indexPath.section == 0) {
            
            static NSString *keyS = @"cell";
            
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:keyS];
            
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:keyS];
            }
            
            cell.textLabel.text = @"12";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
        }
    
    return nil;
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    indexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
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

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY courses == %@", self.course];
    
    [fetchRequest setPredicate:predicate];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor, lastNameDescriptor];
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
    
    if (indexPath.row == 0 && indexPath.section == 1) {
        
        UsersCourseTableViewController *vc = [[UsersCourseTableViewController alloc] init];
        vc.vcStudents = self;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    sectionIndex = sectionIndex-1;
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
    indexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection: indexPath.section+1];
    newIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row+1 inSection: indexPath.section+1];
    
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

#pragma mark - Table View

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 0) {
        return NO;
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        indexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection: indexPath.section-1];
        [self.course removeUsersObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];

    }
}

-(void)dealloc {
    
    NSLog(@"HELLLOOOOOOoóoooooooooooooo");
}


@end
