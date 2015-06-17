//
//  DishCollectionViewCell.h
//  LotusyApp
//
//  Created by Allen on 2015-05-15.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DishCollectionViewCellType) {
    DishCollectionViewCellTypeNormal = 0,
    DishCollectionViewCellTypeGood,
    DishCollectionViewCellTypeBurp,
    DishCollectionViewCellTypeBad,
    DishCollectionViewCellTypeHitList,
    DishCollectionViewCellTypeAdd,
    DishCollectionViewCellTypeCount
};

@interface DishCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) DishCollectionViewCellType type;
@end
