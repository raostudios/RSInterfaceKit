//
//  RSViewController.m
//  RSKit
//
//  Created by Venkat Rao on 04/14/2015.
//  Copyright (c) 2014 Venkat Rao. All rights reserved.
//

#import "RSViewController.h"
#import "RSInterfaceKitLibraryView.h"
#import "RSFullScreenImageTestViewController.h"

@interface RSViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) RSInterfaceKitLibraryView *view;

@end

@implementation RSViewController

@dynamic view;

static NSString *const ItemIdentifier = @"ItemIdentifier";


-(void)loadView {
    self.view = [[RSInterfaceKitLibraryView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.view.tableViewItems registerClass:[UITableViewCell class] forCellReuseIdentifier:ItemIdentifier];
    
    self.view.tableViewItems.dataSource = self;
    self.view.tableViewItems.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ItemIdentifier];
    
    cell.textLabel.text = @"Image Zoom";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RSFullScreenImageTestViewController *viewController = [[RSFullScreenImageTestViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
