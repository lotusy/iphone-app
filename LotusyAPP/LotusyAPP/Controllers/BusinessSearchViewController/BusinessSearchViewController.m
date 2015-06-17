//
//  BusinessSearchViewController.m
//  LotusyApp
//
//  Created by Allen on 2015-04-30.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "BusinessSearchViewController.h"
#import "Business.h"

#define BUSINESSSEARCH_CELL_REUSEIDENTIFIER @"BusinessSearchCellReuseIdentifier"
#define MAX_RESTAURANT_NAME_TEXTFIELD_LENGTH 32
#define RESTAURANT_NAME_SEARCH_THRESHOLD 0
#define RESTAURANT_SEARCH_PREDICATE @"name_en CONTAINS[c] %@ OR name_tw CONTAINS[c] %@ OR name_cn CONTAINS[c] %@"

@interface BusinessSearchViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@end

@implementation BusinessSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"New item tried", nil);
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", nil)
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:nil];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.navigationItem.leftBarButtonItem = [self dismissBackBarButtonItem];
    
    UIImage *image = [[UIImage imageNamed:@"37-circle-x"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_clearButton setImage:image
                  forState:UIControlStateNormal];
    [_clearButton setHidden:YES];
    
    [_textField setInputAccessoryView:[self newAccessoryView]];
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

#pragma mark - AccesoryView & AccesoryView Actions
- (UIToolbar *)newAccessoryView
{
    UIBarButtonItem *flexButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:self
                                                                                    action:nil];
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                    target:_textField
                                                                                    action:@selector(resignFirstResponder)];
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    [toolBar setBarStyle:UIBarStyleDefault];
    [toolBar sizeToFit];
    [toolBar setItems:@[flexButtonItem, doneButtonItem] animated:YES];
    
    return toolBar;
}

- (IBAction)clearTextField:(id)sender {
    NSString *name = @"";
    [_textField setText:name];
    [self performFetchWithName:name];
}

#pragma mark - UITableViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"Is it from any of these nearby restaurants?", nil);
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor grayColor];
    header.textLabel.font = [UIFont systemFontOfSize:14];
}

#pragma mark - UITableView configuration
- (NSString *)tableCellReuseIdentifier
{
    return BUSINESSSEARCH_CELL_REUSEIDENTIFIER;
}

#pragma mark - NSFetchedResultController configuration
- (NSString *)entityName
{
    return BUSINESS_ENTITY_NAME;
}

- (NSArray *)sortDescriptors
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name_en" ascending:YES];;
    return @[sortDescriptor];
}

- (void)performFetchWithName:(NSString *)name {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL isActive = (name.length > RESTAURANT_NAME_SEARCH_THRESHOLD);
        _clearButton.hidden = !isActive;
        NSPredicate *predicate = isActive ? [NSPredicate predicateWithFormat:RESTAURANT_SEARCH_PREDICATE, name, name, name] : [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
        [self.fetchedResultsController.fetchRequest setPredicate:predicate];
        NSError *error = nil;
        if (![self.fetchedResultsController performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        [self.tableView reloadData];
    });
    
}

#pragma mark - Configure cell
- (void)configureCell:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    if (![object isKindOfClass:[UITableViewCell class]]) {
        return;
    }
    
    Business *business = (Business *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UITableViewCell *cell = (UITableViewCell *)object;
    cell.textLabel.text = business.name_en;
}

#pragma mark - UITableViewDataSource
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Business *business = (Business *)[self.fetchedResultsController objectAtIndexPath:indexPath];
        [DataManager deleteObject:business
                          context:self.managedObjectContext
                completionHandler:^(NSError *error) {
            
        }];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    NSUInteger newLength = oldLength - rangeLength + replacementLength;

    NSString *name = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    [self performFetchWithName:name];
    
    return (newLength <= MAX_RESTAURANT_NAME_TEXTFIELD_LENGTH);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_textField.editing) {
        [_textField resignFirstResponder];
    }
}

@end
