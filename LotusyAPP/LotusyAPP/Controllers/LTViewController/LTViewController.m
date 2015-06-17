//
//  LTViewController.m
//  LotusyApp
//
//  Created by Allen on 2015-04-28.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "LTViewController.h"

@interface LTViewController ()

@end

@implementation LTViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
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

- (UIBarButtonItem *)dismissBackBarButtonItem {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back btn"]
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(dismissViewController)];
    return barButtonItem;
}

- (void)dismissViewController {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

@end
