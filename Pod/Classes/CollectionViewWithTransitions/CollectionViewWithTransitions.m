//
//  ViewController.m
//  CollectionViewTest
//
//  Created by Venkat Rao on 8/3/15.
//  Copyright (c) 2015 Rao Studios. All rights reserved.
//

#import "CollectionViewWithTransitions.h"
#import "TransitionAnimator.h"

@interface CollectionViewWithTransitions ()<UICollectionViewDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation CollectionViewWithTransitions

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *changeButton = [[UIBarButtonItem alloc] initWithTitle:@"Change"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(changePressed:)];
    self.collectionView.delegate = self;

    self.navigationItem.rightBarButtonItem = changeButton;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
    
    if (self.selectedIndexPath) {
        
        if([self.collectionView numberOfItemsInSection:0] == self.selectedIndexPath.item) {
            
        }
        
        [self.collectionView scrollToItemAtIndexPath:self.selectedIndexPath
                                    atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                            animated:NO];
    }
    self.selectedIndexPath = nil;

    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    self.navigationItem.rightBarButtonItem = (layout.itemSize.width == [self secondLevelWidth]) ? nil : self.navigationItem.rightBarButtonItem;
}

- (void)changePressed:(id)sender {
    
    self.selectedIndexPath = nil;
    
    UICollectionViewFlowLayout *currentLayout = [[UICollectionViewFlowLayout alloc] init];

    currentLayout.itemSize = CGSizeMake([self secondLevelWidth], [self secondLevelWidth]);
    
    CollectionViewWithTransitions *controller = [[CollectionViewWithTransitions alloc] initWithCollectionViewLayout:currentLayout];
    
    id<CollectionViewWithTransitionsDataSource> dataSource = (id<CollectionViewWithTransitionsDataSource>)self.collectionView.dataSource;
    [dataSource setCollectionView:controller.collectionView];
    controller.dataSource = self.dataSource;
    [self.navigationController pushViewController:controller animated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {

    if ([fromVC isKindOfClass:[self class]] && [toVC isKindOfClass:[self class]]) {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        TransitionAnimator *animator = [[TransitionAnimator alloc] init];
        if (layout.itemSize.width != CGRectGetWidth(self.view.frame)) {
            animator.presenting = YES;
        }
        return animator;
    } else {
        return nil;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    if (layout.itemSize.width != [self secondLevelWidth]) {
        self.selectedIndexPath = indexPath;
        UICollectionViewFlowLayout *currentLayout = [[UICollectionViewFlowLayout alloc] init];
        currentLayout.itemSize = CGSizeMake([self secondLevelWidth], [self secondLevelWidth]);
        CollectionViewWithTransitions *controller = [[CollectionViewWithTransitions alloc] initWithCollectionViewLayout:currentLayout];
        id<CollectionViewWithTransitionsDataSource> dataSource = (id<CollectionViewWithTransitionsDataSource>)self.collectionView.dataSource;
        [dataSource setCollectionView:controller.collectionView];
        controller.dataSource =  dataSource;
        controller.selectedIndexPath = indexPath;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (CGFloat) secondLevelWidth {
    return CGRectGetWidth(self.collectionView.frame);
}

@end
