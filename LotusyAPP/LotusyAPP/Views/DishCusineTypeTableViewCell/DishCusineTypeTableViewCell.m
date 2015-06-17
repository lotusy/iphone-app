//
//  DishCusineTypeTableViewCell.m
//  LotusyApp
//
//  Created by Allen on 2015-06-01.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "DishCusineTypeTableViewCell.h"

#define DISHCUSINETYPE_TABLEVIEWCELL_BACKGROUND_COLOR [UIColor colorWithRed: 0.851 green: 0.851 blue: 0.851 alpha: 1]
#define DISHCUSINETYPE_TABLEVIEWCELL_TITLE_COLOR [UIColor colorWithRed: 0.706 green: 0.706 blue: 0.706 alpha: 1]

@interface DishCusineTypeTableViewCell () {
    
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end

@implementation DishCusineTypeTableViewCell

- (void)awakeFromNib {
    
    self.contentView.backgroundColor = DISHCUSINETYPE_TABLEVIEWCELL_BACKGROUND_COLOR;
    
    [_editButton.layer setCornerRadius:13];
    [_editButton.layer setBorderWidth:1];
    [_editButton.layer setBorderColor:DISHCUSINETYPE_TABLEVIEWCELL_TITLE_COLOR.CGColor];
    [_editButton setTitleColor:DISHCUSINETYPE_TABLEVIEWCELL_TITLE_COLOR forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCusineTypeTitle:(NSString *)title subtitle:(NSString *)subtitle {
    NSAttributedString *attributedText = [DishCusineTypeTableViewCell attributedText:title subtitle:subtitle];
    [_titleLabel setAttributedText:attributedText];
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
                              value:DISHCUSINETYPE_TABLEVIEWCELL_TITLE_COLOR
                              range:[text rangeOfString:title]];
    [mAttributedString addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:12]
                              range:[text rangeOfString:title]];
    [mAttributedString addAttribute:NSForegroundColorAttributeName
                              value:[UIColor darkGrayColor]
                              range:[text rangeOfString:subtitle]];
    [mAttributedString addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:12]
                              range:[text rangeOfString:subtitle]];
    [mAttributedString endEditing];
    
    return mAttributedString;
}

@end
