//
//  MenuSelectionViewController.m
//  
//
//  Created by Venkat Rao on 5/26/16.
//
//

#import "MenuSelectionViewController.h"
#import <RSInterfaceKit/MenuSelectionManager.h>

@interface MenuSelectionTestViewController ()<MenuSelectionDataSource, MenuSelectionDelegate>

@property (nonatomic, strong) MenuSelectionManager *manager;
@property (nonatomic, strong) UILabel *labelAlert;

@end

@implementation MenuSelectionTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [MenuSelectionManager new];
    self.manager.delegate = self;
    self.manager.dataSource = self;
    self.manager.parentViewController = self;
    
    self.labelAlert = [UILabel new];
    self.labelAlert.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.labelAlert];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAlert attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAlert attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationItem.titleView = self.manager.buttonMenuSelector;
}

-(NSString *)titleForIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%ld Item", (long)indexPath.item];
}

-(NSUInteger)numberOfCellsInMenuSelectionManager:(MenuSelectionViewController *)manager {
    return 5;
}

-(UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath forManager:(MenuSelectionViewController *)manager {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld Item", (long)indexPath.item];
    return cell;
}

-(void)menuSelectionManager:(MenuSelectionViewController *)manager cellSelectedAtIndexPath:(NSIndexPath *)indexPath {
    self.labelAlert.text = [NSString stringWithFormat:@"%ld Item", (long)indexPath.item];
}

@end
