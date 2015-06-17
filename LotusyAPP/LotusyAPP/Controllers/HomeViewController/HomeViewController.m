//
//  HomeViewController.m
//  LotusyApp
//
//  Created by Allen on 2015-06-06.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "HomeViewController.h"
#import "UICountingLabel.h"
#import "TPSButton.h"
#import "HomeBackgroundView.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UICountingLabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *discoverButton;
@property (weak, nonatomic) IBOutlet UIButton *hitlistButton;
@property (weak, nonatomic) IBOutlet HomeBackgroundView *backgroundView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Home", nil);
    self.navigationItem.leftBarButtonItem = [self dismissBackBarButtonItem];
    
    /* Counting label */
    _countLabel.method = UILabelCountingMethodEaseOut;
    _countLabel.formatBlock = ^NSString* (CGFloat value)
    {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = kCFNumberFormatterNoStyle;
        NSString *formatted = [formatter stringFromNumber:@((int)value)];
        return [NSString stringWithFormat:@"%@",formatted];
    };
    [_countLabel countFromZeroTo:4521];
    
    /* Discover button */
    [_discoverButton.layer setCornerRadius:_discoverButton.frame.size.height/2];
    [_discoverButton.layer setBorderWidth:1];
    [_discoverButton.layer setBorderColor:_discoverButton.titleLabel.textColor.CGColor];
    
    /* Hitlist button */
    [_hitlistButton.layer setCornerRadius:_hitlistButton.frame.size.height/2];
    [_hitlistButton.layer setBorderWidth:1];
    [_hitlistButton.layer setBorderColor:_hitlistButton.titleLabel.textColor.CGColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_backgroundView animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [_backgroundView animated:NO];
    [super viewWillDisappear:animated];
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
    
    if (![sender isKindOfClass:[TPSButton class]]) {
        return;
    }
    
    TPSButton *button = (TPSButton *)sender;
    [button setImage:[UIImage imageNamed:@"mussels@2x.jpg"]];
    
}

- (IBAction)discoverAction:(id)sender {
    [_backgroundView animated:NO];
}

- (IBAction)hitlistAction:(id)sender {
    [_backgroundView animated:YES];
}

@end
