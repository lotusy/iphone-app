//
//  DishCollectionViewCell.m
//  LotusyApp
//
//  Created by Allen on 2015-05-15.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "DishCollectionViewCell.h"

@interface DishCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *tagView;
@end

@implementation DishCollectionViewCell

- (void)awakeFromNib {

    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.backgroundColor = [UIColor clearColor];
    self.backgroundView = backgroundView;
    
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.6];
    self.selectedBackgroundView = selectedBackgroundView;
    
}

- (void)drawRect:(CGRect)rect {
    
    switch (_type) {
        case DishCollectionViewCellTypeGood:
            _tagView.image = [UIImage imageNamed:@"Foodster_Bun-good-1"];
            break;
        case DishCollectionViewCellTypeBurp:
            _tagView.image = [UIImage imageNamed:@"Foodster_Bun-burp-1"];
            break;
        case DishCollectionViewCellTypeBad:
            _tagView.image = [UIImage imageNamed:@"Foodster_Bun-bad-1"];
            break;
        case DishCollectionViewCellTypeHitList:
            _tagView.image = [UIImage imageNamed:@"icn-hitlist"];
            break;
        default:
            _tagView.image = nil;
            break;
    }
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //// Image Declarations
    UIImage* image = _image;
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(7, 7, 85, 85)];
    CGContextSaveGState(context);
    [ovalPath addClip];
    [image drawInRect:CGRectMake(7, 7, image.size.width, image.size.height)
            blendMode:kCGBlendModeNormal
                alpha:(_type == DishCollectionViewCellTypeGood ||
                       _type == DishCollectionViewCellTypeBurp ||
                       _type == DishCollectionViewCellTypeBad) ? 0.4 : 1.0];
    CGContextRestoreGState(context);
    
}

@end
