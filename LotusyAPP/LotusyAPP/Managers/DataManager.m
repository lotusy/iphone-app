//
//  DataManager.m
//  LotusyApp
//
//  Created by Allen on 2015-04-30.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "DataManager.h"

#define STORAGE_FILENAME @"LotusyApp"
#define STORAGE_FILENAME_EXTENSION @"sqlite"
#define MODEL_EXTENSION @"momd"

@interface DataManager ()
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation DataManager

+ (id)sharedInstance
{
    static DataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
    });
    
    return manager;
}

- (id)init
{
    if ((self = [super init]))
    {
        NSLog(@"Initializing Data Manager");
    }
    return self;
}

- (void)dealloc
{
    
}

#pragma mark - CoreData setup
+ (NSManagedObjectContext *)mainContext
{
    return [[DataManager sharedInstance] managedObjectContext];
}

+ (NSManagedObjectContext *)privateContext
{
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    moc.parentContext = [[DataManager sharedInstance] managedObjectContext];
    return moc;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = [self persistentStoreCoordinator];
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:STORAGE_FILENAME
                                              withExtension:MODEL_EXTENSION];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSError *error;
    NSString *pathComponent = [NSString stringWithFormat:@"%@.%@", STORAGE_FILENAME, STORAGE_FILENAME_EXTENSION];
    NSURL *storeUrl = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:pathComponent];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSDictionary *options = nil;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeUrl
                                                         options:options error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's documents directory
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Core Data Saving support
+ (void)saveContextCompletionHandler:(SaveContextCompletionBlock)completion
{
    NSManagedObjectContext *moc = [DataManager mainContext];
    [moc performBlock:^{
        NSError *error;
        if ([moc hasChanges] &&
            ![moc save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
        
        if (completion) {
            completion();
        }
    }];
}

+ (void)saveObject:(NSManagedObject *)object
           context:(NSManagedObjectContext *)context
 completionHandler:(SaveDataCompletionBlock)completion
{
    [context performBlock:^{
        
        NSError *error;
        if ([context hasChanges] &&
            ![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
        
        [DataManager saveContextCompletionHandler:^{
            if (completion) {
                NSManagedObjectContext *mainContext = [DataManager mainContext];
                completion([mainContext objectWithID:object.objectID]);
            }
        }];
        
    }];
}

+ (void)deleteObject:(NSManagedObject *)object
             context:(NSManagedObjectContext *)context
   completionHandler:(DeleteDataCompletionBlock)completion
{
    [context performBlock:^{
        
        [context deleteObject:object];
        
        NSError *error;
        if ([context hasChanges] &&
            ![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        }
        
        [DataManager saveContextCompletionHandler:^{
            if (completion) {
                completion(error);
            }
        }];
    }];
}

@end
