//
//  RSViewController.m
//  RSKit
//
//  Created by Venkat Rao on 04/14/2015.
//  Copyright (c) 2014 Venkat Rao. All rights reserved.
//

#import "RSInterfaceKitLibraryViewController.h"
#import "RSInterfaceKitLibraryView.h"
#import "RSFullScreenImageTestViewController.h"
#import "RSAlertsExampleViewController.h"
#import "RSImageCarouselExampleViewController.h"
#import "RSCarouselViewController.h"

@interface RSInterfaceKitLibraryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) RSInterfaceKitLibraryView *view;

@end

@implementation RSInterfaceKitLibraryViewController

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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ItemIdentifier];
    switch (indexPath.item) {
        case 0:
            cell.textLabel.text = @"Image Zoom";
            break;
        case 1:
            cell.textLabel.text = @"Alert Manager";
            break;
        case 2:
            cell.textLabel.text = @"Image Dissolving Carousel";
            break;
        case 3:
            cell.textLabel.text = @"Image Carousel";
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        RSFullScreenImageTestViewController *viewController = [[RSFullScreenImageTestViewController alloc] init];
        [self showViewController:viewController sender:self];
    } else if (indexPath.item == 1) {
        RSAlertsExampleViewController *viewController = [[RSAlertsExampleViewController alloc] init];
        [self showViewController:viewController sender:self];
    } else if (indexPath.item == 2) {
        RSImageCarouselExampleViewController *viewController = [[RSImageCarouselExampleViewController alloc] init];
        [self showViewController:viewController sender:self];
    } else if (indexPath.item == 3) {
        RSCarouselViewController *viewController = [[RSCarouselViewController alloc] init];
        [self showViewController:viewController sender:self];
    }
}

@end
