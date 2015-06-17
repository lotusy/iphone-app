//
//  DishFoodItemNameTableViewCell.m
//  LotusyApp
//
//  Created by Allen on 2015-06-01.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "DishFoodItemNameTableViewCell.h"

#define DISHFOODITEMNAME_TABLEVIEWCELL_BACKGROUND_COLOR [UIColor colorWithRed: 0.851 green: 0.851 blue: 0.851 alpha: 1]
#define DISHFOODITEMNAME_TABLEVIEWCELL_TITLE_COLOR [UIColor colorWithRed: 0.706 green: 0.706 blue: 0.706 alpha: 1]
#define DISHFOODITEMNAME_TABLEVIEWCELL_TEXTFIELD_COLOR [UIColor colorWithRed:0.945 green:0.631 blue:0.255 alpha:1.000]

@interface DishFoodItemNameTableViewCell () {
    
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *outlineView;
@property (weak, nonatomic) IBOutlet UIButton *veggieButton;
@property (weak, nonatomic) IBOutlet UIButton *veganButton;


@end


@implementation DishFoodItemNameTableViewCell

- (void)awakeFromNib {
    [self.contentView setBackgroundColor:DISHFOODITEMNAME_TABLEVIEWCELL_BACKGROUND_COLOR];
    
    [_titleLabel setTextColor:DISHFOODITEMNAME_TABLEVIEWCELL_TITLE_COLOR];
    
    [_textField setTextColor:DISHFOODITEMNAME_TABLEVIEWCELL_TEXTFIELD_COLOR];
    
    [_outlineView.layer setCornerRadius:5];
    [_outlineView.layer setBorderWidth:1];
    [_outlineView.layer setBorderColor:DISHFOODITEMNAME_TABLEVIEWCELL_TITLE_COLOR.CGColor];
    [_outlineView setBackgroundColor:DISHFOODITEMNAME_TABLEVIEWCELL_BACKGROUND_COLOR];
    
    [self setVeggieButtonSelected:NO];
    [self setVeganButtonSelected:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVeggieButtonSelected:(BOOL)selected {
    UIButton *button = _veggieButton;
    button.selected = !selected;
    [self veggieButtonTapAction:button];
}

- (void)setVeganButtonSelected:(BOOL)selected {
    UIButton *button = _veganButton;
    button.selected = !selected;
    [self veganButtonTapAction:button];
}

- (IBAction)veggieButtonTapAction:(id)sender {
    
    if (![sender isKindOfClass:[UIButton class]]) {
        return;
    }
    
    UIButton *button = (UIButton *)sender;
    [button setTintColor:[UIColor whiteColor]];
    button.selected = !button.selected;
    
    UIImage *image = button.selected ? [[UIImage imageNamed:@"icn-food-veggie"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] : [[UIImage imageNamed:@"icn-food-veggie"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [button setImage:image forState:UIControlStateNormal];
    
}
- (IBAction)veganButtonTapAction:(id)sender {
    
    if (![sender isKindOfClass:[UIButton class]]) {
        return;
    }
    
    UIButton *button = (UIButton *)sender;
    [button setTintColor:[UIColor whiteColor]];
    button.selected = !button.selected;
    
    UIImage *image = button.selected ? [[UIImage imageNamed:@"icn-food-vegan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] : [[UIImage imageNamed:@"icn-food-vegan"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [button setImage:image forState:UIControlStateNormal];
}
@end
