//
//  CDViewController.m
//  LotusyApp
//
//  Created by Allen on 2015-04-30.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "CDViewController.h"

#define COREDATA_TABLEVIEWCELL_IDENTIFIER @"CoreDataTableCellIdentifier"

@interface CDViewController ()

@end

@implementation CDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSManagedObjectContextDidSaveNotification
                                                  object:nil];
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    _fetchedResultsController.delegate = nil;
}

#pragma mark - UITableView configuration
- (void)setTableView
{
    // Overwrite subclass to implement other further table setup
    [_tableView registerClass:[UITableViewCell class]
       forCellReuseIdentifier:[self tableCellReuseIdentifier]];
}

- (NSString *)tableCellReuseIdentifier
{
    // Overwrite subclass to implement different cell identifier
    return COREDATA_TABLEVIEWCELL_IDENTIFIER;
}

#pragma mark - NSFetchedResultController configuration
- (NSString *)entityName
{
    // Overwrite subclass to implement appropriate entity name
    return nil;
}

- (NSEntityDescription *)entityDescription
{
    return [NSEntityDescription entityForName:[self entityName]
                       inManagedObjectContext:[self managedObjectContext]];
}

- (NSPredicate *)predicate
{
    // Overwrite subclass to implement appropriate predicate
    return [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
}

- (NSArray *)sortDescriptors
{
    // Overwrite subclass to implement appropriate sort Descriptor
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"user_id" ascending:YES];
    return @[sortDescriptor];
}

- (NSString *)sectionNameKeyPath
{
    // Edit the section name key path if appropriate.
    // nil for section name key path means "no sections".
    return nil;
}

- (NSString *)cacheName
{
    // Edit the cache name if appropriate.
    // nil for cache name means "no cache".
    return nil;
}

#pragma mark - UITableViewDatasource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self tableCellReuseIdentifier]
                                                            forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor grayColor];
    [self configureCell:cell
            atIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Overwrite subclass to implement appropriate actions
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    id object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSLog(@"%@", object);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Overwrite subclass to implement appropriate actions
    }
}

#pragma mark - Configure cell
- (void)configureCell:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    // Overwrite subclass to implement appropriate actions
}


#pragma mark - NSManagedObjectContext
- (void)updateMainContext:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self managedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
    });
}

- (void)mergeChanges:(NSNotification *)notification
{
    NSManagedObjectContext *moc = (NSManagedObjectContext *)[notification object];
    if (moc != [self managedObjectContext] &&
        moc.persistentStoreCoordinator == [[self managedObjectContext] persistentStoreCoordinator]) {
        [self performSelectorOnMainThread:@selector(updateMainContext:)
                               withObject:notification
                            waitUntilDone:NO];
    }
}

- (NSManagedObjectContext *)managedObjectContext
{
    return [DataManager mainContext];
}

#pragma mark - NSFetchedResultsController
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    // Set up the fetched results controller if needed.
    _fetchedResultsController = [self newFetchedResultsController];
    
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error]) {
        //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _fetchedResultsController;
}

- (NSFetchedResultsController *)newFetchedResultsController
{
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[self entityDescription]];
    [fetchRequest setSortDescriptors:[self sortDescriptors]];
    [fetchRequest setPredicate:[self predicate]];
    
    NSFetchedResultsController *fetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:[self managedObjectContext]
                                          sectionNameKeyPath:[self sectionNameKeyPath]
                                                   cacheName:[self cacheName]];
    fetchedResultsController.delegate = self;
    
    return fetchedResultsController;
}

#pragma mark - NSFetchedResultsController delegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [_tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [_tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                      withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [_tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                      withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                      withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeMove:
            NSLog(@"NSFetchedResultsChangeMove:");
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeMove:
            [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
            [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [_tableView endUpdates];
}

@end
