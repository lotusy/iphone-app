//
//  DishTakePhotoTableViewCell.m
//  LotusyApp
//
//  Created by Allen on 2015-06-01.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "DishTakePhotoTableViewCell.h"

#define DISHTAKEPHOTO_TABLEVIEWCELL_BACKGROUND_COLOR [UIColor colorWithRed: 0.851 green: 0.851 blue: 0.851 alpha: 1]

@interface DishTakePhotoTableViewCell () {
    
}
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (weak, nonatomic) IBOutlet UIImageView *pinView;

@end

@implementation DishTakePhotoTableViewCell

- (void)awakeFromNib {

    [_takePhotoButton setBackgroundColor:DISHTAKEPHOTO_TABLEVIEWCELL_BACKGROUND_COLOR];
    
    UIImage *image = [[UIImage imageNamed:@"pin15"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_pinView setImage:image];
    [_pinView setTintColor:DISHTAKEPHOTO_TABLEVIEWCELL_BACKGROUND_COLOR];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAttributedText:(NSString *)title subtitle:(NSString *)subtitle {
    NSAttributedString *attributedText = [DishTakePhotoTableViewCell attributedText:title
                                                                           subtitle:subtitle];
    [_addressLabel setAttributedText:attributedText];
}

+ (NSAttributedString *)attributedText:(NSString *)title subtitle:(NSString *)subtitle {
    if (!title) {
        title = @"title";
    }
    
    if (!subtitle) {
        subtitle = @"subtitle";
    }
    
    NSString *text = [NSString stringWithFormat:@"%@ %@", title, subtitle];
    NSArray *array = [text componentsSeparatedByString:@"\n"];
    if (array) {
        title = [array firstObject];
    }
    
    NSMutableAttributedString *mAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [mAttributedString beginEditing];
    [mAttributedString addAttribute:NSForegroundColorAttributeName
                              value:[UIColor darkGrayColor]
                              range:[text rangeOfString:title]];
    [mAttributedString addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:12]
                              range:[text rangeOfString:title]];
    [mAttributedString addAttribute:NSForegroundColorAttributeName
                              value:[UIColor lightGrayColor]
                              range:[text rangeOfString:subtitle]];
    [mAttributedString addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:10]
                              range:[text rangeOfString:subtitle]];
    [mAttributedString endEditing];
    
    return mAttributedString;
}

@end
