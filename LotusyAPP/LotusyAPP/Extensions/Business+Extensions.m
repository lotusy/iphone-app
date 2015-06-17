//
//  Business+Extensions.m
//  LotusyApp
//
//  Created by Allen on 2015-04-30.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "Business+Extensions.h"
#import "DataManager.h"
#import "NSObject+Extensions.h"

#define BUSINESS_CASH_ONLY_KEY @"cash_only"
#define BUSINESS_COMMENT_COUNT_KEY @"comment_count"
#define BUSINESS_DISTANCE_KEY @"distance"
#define BUSINESS_ID_KEY @"id"
#define BUSINESS_IMAGE_KEY @"image"
#define BUSINESS_NAME_EN_KEY @"name_en"
#define BUSINESS_NAME_TW_KEY @"name_tw"
#define BUSINESS_NAME_CN_KEY @"name_zh"
#define BUSINESS_PRICE_KEY @"price"
#define BUSINESS_LATITUDE_KEY @"lat"
#define BUSINESS_LONGITUDE_KEY @"lng"

@implementation Business (Extensions)

+ (void)newBusinessData:(NSDictionary *)dictionary
      completionHandler:(BusinessCompletionBlock)completion
{
    NSManagedObjectContext *privateContext = [DataManager privateContext];
    [privateContext performBlock:^{
        
        NSString *string = dictionary[BUSINESS_ID_KEY];
        if (![string isNonNilString]) {
            if (completion) {
                completion(nil);
            }
            return;
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"business_id == %@", string];
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:BUSINESS_ENTITY_NAME];
        request.predicate = predicate;
        NSError *error = nil;
        NSArray *results = [privateContext executeFetchRequest:request
                                                         error:&error];
        if ([results.firstObject isNonNilBusiness]) {
            if (completion) {
                completion((Business *)results.firstObject);
            }
            return;
        }
    
        NSEntityDescription *description = [NSEntityDescription entityForName:BUSINESS_ENTITY_NAME
                                                       inManagedObjectContext:privateContext];
        Business *business = [[Business alloc] initWithEntity:description
                               insertIntoManagedObjectContext:privateContext];
        
        business.business_id = [NSNumber numberWithInteger:string.integerValue];
        
        string = dictionary[BUSINESS_CASH_ONLY_KEY];
        if ([string isNonNilString]) {
            business.cash_only = [string isEqualToString:@"N"] ? [NSNumber numberWithBool:NO] : [NSNumber numberWithBool:YES];
        }
        
        NSNumber *number = dictionary[BUSINESS_COMMENT_COUNT_KEY];
        if ([number isNonNilNumber]) {
            business.comment_count = number;
        }
        
        number = dictionary[BUSINESS_DISTANCE_KEY];
        if ([number isNonNilNumber]) {
            business.distance = number;
        }
                
        string = dictionary[BUSINESS_LATITUDE_KEY];
        if ([string isNonNilString]) {
            business.lat = [NSNumber numberWithDouble:string.doubleValue];
        }
        
        string = dictionary[BUSINESS_LONGITUDE_KEY];
        if ([string isNonNilString]) {
            business.lng = [NSNumber numberWithDouble:string.doubleValue];
        }
        
        string = dictionary[BUSINESS_NAME_EN_KEY];
        if ([string isNonNilString]) {
            business.name_en = string;
        }
        
        string = dictionary[BUSINESS_NAME_TW_KEY];
        if ([string isNonNilString]) {
            business.name_tw = string;
        }
        
        string = dictionary[BUSINESS_NAME_CN_KEY];
        if ([string isNonNilString]) {
            business.name_cn = string;
        }
        
        string = dictionary[BUSINESS_PRICE_KEY];
        if ([string isNonNilString]) {
            business.price = string;
        }
        
        [DataManager saveObject:business
                        context:privateContext
              completionHandler:^(NSManagedObject *object) {
                  if ([object isNonNilBusiness]) {
                      if (completion) {
                          completion((Business *)object);
                      }
                  }
              }];
        
    }];
    
}

@end
