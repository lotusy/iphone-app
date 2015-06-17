//
//  DishViewController.m
//  LotusyApp
//
//  Created by Allen on 2015-05-29.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "DishViewController.h"
#import "DishTakePhotoTableViewCell.h"
#import "DishFoodItemNameTableViewCell.h"
#import "DishCusineTypeTableViewCell.h"
#import "DishCategoryTableViewCell.h"
#import "DishPriceTableViewCell.h"

#define DISHVIEW_CELL_REUSEIDENTIFIER @"DishViewCellReuseIdentifier"
#define DISHVIEW_BACKGROUND_COLOR [UIColor colorWithRed: 0.851 green: 0.851 blue: 0.851 alpha: 1]
#define DISHTAKEPHOTOVIEW_CELL_REUSEIDENTIFIER @"DishTakePhotoViewCellReuseIdentifier"
#define DISHFOODITEMNAMEVIEW_CELL_REUSEIDENTIFIER @"DishFoodItemNameViewCellReuseIdentifier"
#define DISHCUSINETYPEVIEW_CELL_REUSEIDENTIFIER @"DishCusineTypeViewCellReuseIdentifier"
#define DISHCATEGORYVIEW_CELL_REUSEIDENTIFIER @"DishCategoryViewCellReuseIdentifier"
#define DISHPRICEVIEW_CELL_REUSEIDENTIFIER @"DishPriceViewCellReuseIdentifier"

typedef NS_ENUM(NSInteger, DishViewControllerCell) {
    DishViewControllerCellTakePhoto            = 0,
    DishViewControllerCellFoodItemName,
    DishViewControllerCellCusineType,
    DishViewControllerCellCategory,
    DishViewControllerCellPrice,
    DishViewControllerCellCount
};

@interface DishViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Add Food Item", nil);
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil)
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:nil];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.navigationItem.leftBarButtonItem = [self dismissBackBarButtonItem];

    _tableView.backgroundColor = DISHVIEW_BACKGROUND_COLOR;
    [_tableView registerClass:[UITableViewCell class]
       forCellReuseIdentifier:DISHVIEW_CELL_REUSEIDENTIFIER];
    [_tableView registerNib:[UINib nibWithNibName:@"DishTakePhotoTableViewCell" bundle:nil]
       forCellReuseIdentifier:DISHTAKEPHOTOVIEW_CELL_REUSEIDENTIFIER];
    [_tableView registerNib:[UINib nibWithNibName:@"DishFoodItemNameTableViewCell" bundle:nil]
     forCellReuseIdentifier:DISHFOODITEMNAMEVIEW_CELL_REUSEIDENTIFIER];
    [_tableView registerNib:[UINib nibWithNibName:@"DishCusineTypeTableViewCell" bundle:nil]
     forCellReuseIdentifier:DISHCUSINETYPEVIEW_CELL_REUSEIDENTIFIER];
    [_tableView registerNib:[UINib nibWithNibName:@"DishCategoryTableViewCell" bundle:nil]
     forCellReuseIdentifier:DISHCATEGORYVIEW_CELL_REUSEIDENTIFIER];
    [_tableView registerNib:[UINib nibWithNibName:@"DishPriceTableViewCell" bundle:nil]
     forCellReuseIdentifier:DISHPRICEVIEW_CELL_REUSEIDENTIFIER];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return DishViewControllerCellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case DishViewControllerCellTakePhoto: {
            DishTakePhotoTableViewCell *cell = (DishTakePhotoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:DISHTAKEPHOTOVIEW_CELL_REUSEIDENTIFIER
                                                                                       forIndexPath:indexPath];
            [cell setAttributedText:@"Sushi Garden" subtitle:@"0.6mi - 4652 Kingsway, Burnaby, BC"];
            return cell;
        } break;
        case DishViewControllerCellFoodItemName: {
            DishFoodItemNameTableViewCell *cell = (DishFoodItemNameTableViewCell *)[tableView dequeueReusableCellWithIdentifier:DISHFOODITEMNAMEVIEW_CELL_REUSEIDENTIFIER forIndexPath:indexPath];
            [cell setVeggieButtonSelected:NO];
            [cell setVeganButtonSelected:YES];
            return cell;
        } break;
        case DishViewControllerCellCusineType: {
            DishCusineTypeTableViewCell *cell = (DishCusineTypeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:DISHCUSINETYPEVIEW_CELL_REUSEIDENTIFIER forIndexPath:indexPath];
            [cell setCusineTypeTitle:NSLocalizedString(@"Cuisine Type", nil) subtitle:@"Japanese | take-out"];
            return cell;
        } break;
        case DishViewControllerCellCategory: {
            DishCategoryTableViewCell *cell = (DishCategoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:DISHCATEGORYVIEW_CELL_REUSEIDENTIFIER forIndexPath:indexPath];
            [cell setDishCategoryType:DishCategoryTypeEntree];
            return cell;
        } break;
        case DishViewControllerCellPrice: {
            DishPriceTableViewCell *cell = (DishPriceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:DISHPRICEVIEW_CELL_REUSEIDENTIFIER forIndexPath:indexPath];
            return cell;
        } break;
        default: {
            UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:DISHVIEW_CELL_REUSEIDENTIFIER
                                                                                       forIndexPath:indexPath];
            return cell;
        } break;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *view = [self viewHeightForRowAtIndexPath:indexPath];
    return view ? view.frame.size.height : 0;
}

- (UIView *)viewHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *nibName = @"";
    switch (indexPath.row) {
        case DishViewControllerCellTakePhoto: nibName = @"DishTakePhotoTableViewCell"; break;
        case DishViewControllerCellFoodItemName: nibName = @"DishFoodItemNameTableViewCell"; break;
        case DishViewControllerCellCusineType: nibName = @"DishCusineTypeTableViewCell"; break;
        case DishViewControllerCellCategory: nibName = @"DishCategoryTableViewCell"; break;
        case DishViewControllerCellPrice: nibName = @"DishPriceTableViewCell"; break;
        default:
            break;
    }
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:nibName
                                                   owner:self
                                                 options:nil];
    return (UIView *)[array firstObject];
}
@end
