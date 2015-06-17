//
//  Business.h
//  LotusyApp
//
//  Created by Allen on 2015-05-02.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Business : NSManagedObject

@property (nonatomic, retain) NSNumber * business_id;
@property (nonatomic, retain) NSNumber * cash_only;
@property (nonatomic, retain) NSNumber * comment_count;
@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * name_cn;
@property (nonatomic, retain) NSString * name_en;
@property (nonatomic, retain) NSString * name_tw;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lng;

@end
