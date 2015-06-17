//
//  DishCategoryTableViewCell.h
//  LotusyApp
//
//  Created by Allen on 2015-06-01.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DishCategoryType) {
    DishCategoryTypeDrink           = 0,
    DishCategoryTypeAppy,
    DishCategoryTypeEntree,
    DishCategoryTypeDessert,
    DishCategoryTypeCount
};

@interface DishCategoryTableViewCell : UITableViewCell
- (void)setDishCategoryType:(DishCategoryType)type;
@end
