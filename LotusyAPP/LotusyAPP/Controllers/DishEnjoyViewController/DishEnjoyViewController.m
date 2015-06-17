//
//  DishEnjoyViewController.m
//  LotusyApp
//
//  Created by Allen on 2015-05-15.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "DishEnjoyViewController.h"
#import "DishEnjoyedViewController.h"
#import "TPButton.h"

#define DISH_ENJOY_BACKGROUND_COLOR [UIColor colorWithRed:0.984 green:0.863 blue:0.314 alpha:1.000]

@interface DishEnjoyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (weak, nonatomic) IBOutlet UIButton *mehButton;
@property (weak, nonatomic) IBOutlet UIButton *yumButton;
@property (weak, nonatomic) IBOutlet TPButton *takePhotoButton;
@end

@implementation DishEnjoyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"New item tried", nil);
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil)
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(presentDishEnjoyedViewController)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.navigationItem.leftBarButtonItem = [self dismissBackBarButtonItem];
    self.view.backgroundColor = DISH_ENJOY_BACKGROUND_COLOR;
    
    _promptLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Did you enjoy the %@?", nil), @"(Dish Name)"];
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

- (IBAction)takePhotoAction:(id)sender {
    if (![sender isKindOfClass:[TPButton class]]) {
        return;
    }
    
    TPButton *button = (TPButton *)sender;
    [button setImage:[UIImage imageNamed:@"mussels@2x.jpg"]];
}

- (IBAction)mehDishAction:(id)sender {
    if (![sender isKindOfClass:[UIButton class]]) {
        return;
    }
    
    UIButton *button = (UIButton *)sender;
    if (button.selected) {
        return;
    }
    
    button.selected = !button.selected;
    _yumButton.selected = !button.selected;
}

- (IBAction)yumDishAction:(id)sender {
    if (![sender isKindOfClass:[UIButton class]]) {
        return;
    }
    
    UIButton *button = (UIButton *)sender;
    if (button.selected) {
        return;
    }
    
    button.selected = !button.selected;
    _mehButton.selected = !button.selected;
}

- (void)presentDishEnjoyedViewController {
    DishEnjoyedViewController *vc = [[DishEnjoyedViewController alloc] initWithNibName:@"DishEnjoyedViewController"
                                                                                bundle:nil];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    nc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:nc animated:YES completion:^{
        
    }];
}

@end
