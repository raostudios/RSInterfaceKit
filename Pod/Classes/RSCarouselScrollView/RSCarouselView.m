//
//  CorouselView.m
//  RSStoreKit
//
//  Created by Rao, Venkat on 3/12/15.
//  Copyright (c) 2015 Rao, Venkat. All rights reserved.
//

#import "RSCarouselView.h"

@interface RSCarouselView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSTimer *scrollTimer;
@property (nonatomic, strong) NSString *carouselCellIdentifier;

@end

@implementation RSCarouselView

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layout = [[UICollectionViewFlowLayout alloc] init];
        self.layout.minimumInteritemSpacing = 0.0f;
        self.layout.minimumLineSpacing = 0.0f;
        
        self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                 collectionViewLayout:self.layout];
        self.collectionView.pagingEnabled = YES;
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.collectionView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"collectionView":self.collectionView}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"collectionView":self.collectionView}]];
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
    }
    return self;
}

-(void) scroll {
    NSIndexPath *indexPath = [self indexPathForItemAtCenterOfCollectionView:self.collectionView];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item + 1 inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:YES];
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ([self.dataSource numberOfItemsInCarouselView:self] + 2);
}

-(void) collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    ;
    NSIndexPath *newIndexPath = [self indexPathForItemAtCenterOfCollectionView:collectionView];
    if (newIndexPath.item == [collectionView numberOfItemsInSection:0] - 1) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionLeft
                                            animated:NO];
    }

    if (newIndexPath.item == 0 && indexPath.item == 1) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:([collectionView numberOfItemsInSection:0] - 2)  inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionLeft
                                            animated:NO];
    }
}

-(NSIndexPath *) indexPathForItemAtCenterOfCollectionView:(UICollectionView *)collectionView {
    return [collectionView indexPathForItemAtPoint:CGPointMake(collectionView.center.x + collectionView.contentOffset.x, collectionView.center.y + collectionView.contentOffset.y)];
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.scrollTimer invalidate];
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.carouselCellIdentifier forIndexPath:indexPath];
    
    if (indexPath.item == 0 || indexPath.item == ([collectionView numberOfItemsInSection:0] - 2)) {
        [self.dataSource configureCell:cell InCarouselView:self atIndex:([self.dataSource numberOfItemsInCarouselView:self] - 1)];
    } else if (indexPath.item == 1 || indexPath.item == ([collectionView numberOfItemsInSection:0] - 1)) {
        [self.dataSource configureCell:cell InCarouselView:self atIndex:0];
    } else {
        [self.dataSource configureCell:cell InCarouselView:self atIndex:(indexPath.item - 1)];
    }
    
    return cell;
}

-(void) registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    self.carouselCellIdentifier = identifier;
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

-(void) start {
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:5
                                                        target:self
                                                      selector:@selector(scroll)
                                                      userInfo:nil
                                                       repeats:YES];
}

-(void) stop {
    [self.scrollTimer invalidate];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.layout.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView.bounds),
                                      CGRectGetHeight(self.collectionView.bounds));
    [self.layout invalidateLayout];
    self.collectionView.contentOffset = CGPointMake(CGRectGetWidth(self.collectionView.bounds), 0);
}

@end
