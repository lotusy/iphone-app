//
//  DataManager.h
//  LotusyApp
//
//  Created by Allen on 2015-04-30.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void(^SaveContextCompletionBlock)(void);
typedef void(^SaveDataCompletionBlock)(NSManagedObject *object);
typedef void(^DeleteDataCompletionBlock)(NSError *error);

#define BUSINESS_ENTITY_NAME @"Business"

@interface DataManager : NSObject
+ (id)sharedInstance;
+ (NSManagedObjectContext *)mainContext;
+ (NSManagedObjectContext *)privateContext;
+ (void)saveObject:(NSManagedObject *)object
           context:(NSManagedObjectContext *)context
 completionHandler:(SaveDataCompletionBlock)completion;
+ (void)deleteObject:(NSManagedObject *)object
             context:(NSManagedObjectContext *)context
   completionHandler:(DeleteDataCompletionBlock)completion;
+ (void)saveContextCompletionHandler:(SaveContextCompletionBlock)completion;
@end
