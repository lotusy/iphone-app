//
//  DishPriceTableViewCell.m
//  LotusyApp
//
//  Created by Allen on 2015-06-07.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "DishPriceTableViewCell.h"
#import "LTSlider.h"

#define DISHPRICE_TABLEVIEWCELL_BACKGROUND_COLOR [UIColor colorWithRed: 0.851 green: 0.851 blue: 0.851 alpha: 1]

@implementation DishPriceTableViewCell

- (void)awakeFromNib {
    
    self.contentView.backgroundColor = DISHPRICE_TABLEVIEWCELL_BACKGROUND_COLOR;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
