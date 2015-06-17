//
//  DishCategoryTableViewCell.m
//  LotusyApp
//
//  Created by Allen on 2015-06-01.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "DishCategoryTableViewCell.h"

#define DISHCATEGORY_TABLEVIEWCELL_BACKGROUND_COLOR [UIColor colorWithRed: 0.851 green: 0.851 blue: 0.851 alpha: 1]
#define DISHCATEGORY_TABLEVIEWCELL_TITLE_COLOR [UIColor colorWithRed: 0.706 green: 0.706 blue: 0.706 alpha: 1]
#define DISHCATEGORY_TABLEVIEWCELL_SELECTEDBUTTON_COLOR [UIColor colorWithRed: 0.992 green: 0.882 blue: 0.404 alpha: 1]

@interface DishCategoryTableViewCell () {
    
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *drinkButton;
@property (weak, nonatomic) IBOutlet UIButton *appyButton;
@property (weak, nonatomic) IBOutlet UIButton *entreeButton;
@property (weak, nonatomic) IBOutlet UIButton *dessertButton;
@property (assign) DishCategoryType type;
@end


@implementation DishCategoryTableViewCell

- (void)awakeFromNib {
    
    self.contentView.backgroundColor = DISHCATEGORY_TABLEVIEWCELL_BACKGROUND_COLOR;
    
    [_titleLabel setTextColor:DISHCATEGORY_TABLEVIEWCELL_TITLE_COLOR];
}

- (void)setDishCategoryType:(DishCategoryType)type {
    NSArray *array = @[_drinkButton, _appyButton, _entreeButton, _dessertButton];
    for (NSInteger i = 0; i < DishCategoryTypeCount; i++) {
        UIButton *button = (UIButton *)[array objectAtIndex:i];
        [button setTintColor:[UIColor clearColor]];
        [button setTitleColor:DISHCATEGORY_TABLEVIEWCELL_TITLE_COLOR forState:UIControlStateNormal];
        [button setTitleColor:DISHCATEGORY_TABLEVIEWCELL_TITLE_COLOR forState:UIControlStateSelected];
        button.selected = (i == type);
        button.tag = i;
        
        UIColor *color = button.selected ? DISHCATEGORY_TABLEVIEWCELL_SELECTEDBUTTON_COLOR : [UIColor whiteColor];
        [button setBackgroundColor:color];
    }
}

- (IBAction)drinkButtonTapAction:(id)sender {

    [self setDishCategoryType:DishCategoryTypeDrink];
    
}

- (IBAction)appyButtonTapAction:(id)sender {
    
    [self setDishCategoryType:DishCategoryTypeAppy];
}

- (IBAction)entreeButtonTapAction:(id)sender {
    
    [self setDishCategoryType:DishCategoryTypeEntree];
    
}

- (IBAction)dessertButtonTapAction:(id)sender {
    
    [self setDishCategoryType:DishCategoryTypeDessert];
    
}

@end
