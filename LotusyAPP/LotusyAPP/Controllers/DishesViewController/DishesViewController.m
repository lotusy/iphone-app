//
//  DishesViewController.m
//  LotusyApp
//
//  Created by Allen on 2015-05-15.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "DishesViewController.h"
#import "DishCollectionViewCell.h"

#define DISHES_CELL_REUSEIDENTIFIER @"DishesCellReuseIdentifier"

@interface DishesViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@end

@implementation DishesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"New item tried", nil);
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", nil)
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:nil];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.navigationItem.leftBarButtonItem = [self dismissBackBarButtonItem];
    
    NSString *text = [NSString stringWithFormat:NSLocalizedString(@"Which item did you try at %@", nil), @"(Business Name)"];
    [_headerLabel setText:text];
    [_collectionView registerNib:[UINib nibWithNibName:@"DishCollectionViewCell" bundle:nil]
      forCellWithReuseIdentifier:DISHES_CELL_REUSEIDENTIFIER];
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

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DishCollectionViewCell *cell = (DishCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:DISHES_CELL_REUSEIDENTIFIER forIndexPath:indexPath];
    switch (indexPath.row) {
        case 8:
            cell.type = DishCollectionViewCellTypeAdd;
            cell.titleLabel.text = @"";
            cell.image = [UIImage imageNamed: @"additem"];
            break;
        case 0:
            cell.type = DishCollectionViewCellTypeHitList;
            cell.titleLabel.text = @"Assorted Sashimi Deluxe";
            cell.image = [UIImage imageNamed: @"sushi"];
            break;
        case 1:
            cell.type = DishCollectionViewCellTypeGood;
            cell.titleLabel.text = @"Pizza";
            cell.image = [UIImage imageNamed: @"pizza"];
            break;
        default:
            cell.type = DishCollectionViewCellTypeNormal;
            cell.titleLabel.text = @"Some combo with a long";
            cell.image = [UIImage imageNamed: @"needphoto"];
            break;
    }
    [cell setNeedsDisplay]; // <- Force to redraw according to properties
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
@end
