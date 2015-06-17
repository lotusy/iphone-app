//
//  DishEnjoyedViewController.m
//  LotusyApp
//
//  Created by Allen on 2015-05-26.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "DishEnjoyedViewController.h"

#define BUTTON_TINT_COLOR [UIColor colorWithRed:0.541 green:0.357 blue:0.122 alpha:1.000]
#define BUTTON_IMAGE [[UIImage imageNamed:@"cross26"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]

@interface DishEnjoyedViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation DishEnjoyedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor clearColor];
    
    [_cancelButton setImage:BUTTON_IMAGE
                   forState:UIControlStateNormal];
    [_cancelButton setTintColor:BUTTON_TINT_COLOR];
    
    [_doneButton.layer setMasksToBounds:YES];
    [_doneButton.layer setCornerRadius:15];
    
    [_imageView setImage:[UIImage imageNamed:@"bun-yum"]];
    
    _countLabel.text = @"4522";
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
- (IBAction)dismissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES
                             completion:^{

    }];
}

- (IBAction)facebookShare:(id)sender {
    NSLog(@"facebook");
}

- (IBAction)twitterShare:(id)sender {
    NSLog(@"twitter");
}

- (IBAction)sinaShare:(id)sender {
    NSLog(@"sina");
}

@end
