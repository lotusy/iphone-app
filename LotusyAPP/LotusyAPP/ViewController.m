//
//  ViewController.m
//  LotusyAPP
//
//  Created by Peng Shen on 2015-03-16.
//  Copyright (c) 2015 Foodster Club Inc. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "BusinessSearchViewController.h"
#import "DishesViewController.h"
#import "DishViewController.h"
#import "DishEnjoyViewController.h"

#define ROOT_CELL_REUSEIDENTIFIER @"RootCellReuseIdentifier"

typedef NS_ENUM(NSInteger, RootViewControllerCell) {
    RootViewControllerCellHome                      = 0,
    RootViewControllerCellBusinessSearch            = 1,
    RootViewControllerCellDishes                    = 2,
    RootViewControllerCellDish                      = 3,
    RootViewControllerCellDishEnjoy                 = 4,
    RootViewControllerCellCount                     = 5
};

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Foodster", "");
    [_tableView registerClass:[UITableViewCell class]
       forCellReuseIdentifier:ROOT_CELL_REUSEIDENTIFIER];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return RootViewControllerCellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:ROOT_CELL_REUSEIDENTIFIER
                                                                               forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.text = [self cellTitleAtIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIViewController *vc = [self didSelectViewControllerAtIndexPath:indexPath];
    if (!vc) {
        return;
    }
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:^{
        
    }];
}

- (UIViewController *)didSelectViewControllerAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case RootViewControllerCellHome:
            return [[HomeViewController alloc] initWithNibName:@"HomeViewController"
                                                        bundle:nil];
            break;
        case RootViewControllerCellBusinessSearch:
            return [[BusinessSearchViewController alloc] initWithNibName:@"BusinessSearchViewController"
                                                                  bundle:nil];
            break;
        case RootViewControllerCellDishes:
            return [[DishesViewController alloc] initWithNibName:@"DishesViewController"
                                                          bundle:nil];
            break;
        case RootViewControllerCellDish:
            return [[DishViewController alloc] initWithNibName:@"DishViewController"
                                                        bundle:nil];
            break;
        case RootViewControllerCellDishEnjoy:
            return [[DishEnjoyViewController alloc] initWithNibName:@"DishEnjoyViewController"
                                                             bundle:nil];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)cellTitleAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case RootViewControllerCellHome: return @"HOME"; break;
        case RootViewControllerCellBusinessSearch: return @"BUSINESS SEARCH"; break;
        case RootViewControllerCellDishes: return @"DISHES"; break;
        case RootViewControllerCellDish: return @"DISH"; break;
        case RootViewControllerCellDishEnjoy: return @"DISH ENJOY/ DISH ENJOYED"; break;
        default: return @"UNSPECIFIED"; break;
    }
}

@end

