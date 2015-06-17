//
//  CDViewController.h
//  LotusyApp
//
//  Created by Allen on 2015-04-30.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "LTViewController.h"
#import "DataManager.h"

@interface CDViewController : LTViewController<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (NSString *)tableCellReuseIdentifier;
- (void)configureCell:(id)object
          atIndexPath:(NSIndexPath *)indexPath;

@end
