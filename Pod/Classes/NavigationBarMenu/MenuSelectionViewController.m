//
//  AlbumSelectorViewController.m
//  Preset
//
//  Created by Venkat Rao on 4/6/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import "MenuSelectionViewController.h"
#import "MenuSelectorView.h"

@interface MenuSelectionViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) MenuSelectorView *view;

@end

@implementation MenuSelectionViewController

@dynamic view;

-(void)loadView {
    self.view = [[MenuSelectorView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view.tableView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.topLayoutGuide
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    self.view.tableView.dataSource = self;
    self.view.tableView.delegate = self;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfCellsInMenuSelectionManager:self];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource cellForRowAtIndexPath:indexPath forManager:self];
}

-(NSLayoutConstraint *)constraintHeight {
    return self.view.constraintHeight;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate menuSelectionManager:self cellSelectedAtIndexPath:indexPath];
}

-(UIView *)overlayView {
    return self.view.overlayView;
}

@end
