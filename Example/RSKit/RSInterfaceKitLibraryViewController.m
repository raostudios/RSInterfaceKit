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
#import "RSZoomImageToImageViewController.h"
#import "CollectionViewWithTransitions.h"
#import "CollectionViewDataSource.h"
#import "RSSettingsViewController.h"
#import "RSToolTipsViewController.h"
#import "MenuSelectionViewController.h"

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
    
    self.title = @"Available Components";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ItemIdentifier forIndexPath:indexPath];
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
            break;
        case 4:
            cell.textLabel.text = @"Zoomable Full Screen Image";
            break;
        case 5:
            cell.textLabel.text = @"Collection View Transitions";
            break;
        case 6:
            cell.textLabel.text = @"Settings View";
            break;
        case 7:
            cell.textLabel.text = @"Pop Up";
            break;
        case 8:
            cell.textLabel.text = @"Navigation Bar Menu";
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        RSFullScreenImageTestViewController *viewController = [[RSFullScreenImageTestViewController alloc] init];
        [self showDetailViewController:viewController sender:self];
    } else if (indexPath.item == 1) {
        RSAlertsExampleViewController *viewController = [[RSAlertsExampleViewController alloc] init];
        [self showDetailViewController:viewController sender:self];
    } else if (indexPath.item == 2) {
        RSImageCarouselExampleViewController *viewController = [[RSImageCarouselExampleViewController alloc] init];
        [self showDetailViewController:viewController sender:self];
    } else if (indexPath.item == 3) {
        RSCarouselViewController *viewController = [[RSCarouselViewController alloc] init];
        [self showDetailViewController:viewController sender:self];
    } else if (indexPath.item == 4) {
        RSZoomImageToImageViewController *viewController = [[RSZoomImageToImageViewController alloc] init];
        [self showDetailViewController:viewController sender:self];
    } else if (indexPath.item == 5) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        
        CGFloat width = (CGRectGetWidth([UIScreen mainScreen].bounds) - layout.minimumInteritemSpacing * 2) / 3.0;
        
        layout.itemSize = CGSizeMake(width, width);
        
        CollectionViewWithTransitions *viewController = [[CollectionViewWithTransitions alloc] initWithCollectionViewLayout:layout];
        viewController.dataSource = [[CollectionViewDataSource alloc] initWithCollectionView:viewController.collectionView];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        navigationController.navigationBar.barTintColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];;
        [self showDetailViewController:navigationController sender:self];

    } else if (indexPath.item == 6) {
        RSSettingsViewController *settingsViewController = [RSSettingsViewController new];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
        [self showDetailViewController:navigationController sender:self];
    } else if (indexPath.item == 7) {
        RSToolTipsViewController *toolTipsViewController = [RSToolTipsViewController new];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:toolTipsViewController];
        [self showDetailViewController:navigationController sender:self];
    } else if (indexPath.item == 8) {
        MenuSelectionViewController *menuSelectionViewController = [MenuSelectionViewController new];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:menuSelectionViewController];
        [self showDetailViewController:navigationController sender:self];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
