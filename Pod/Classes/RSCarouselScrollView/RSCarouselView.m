//
//  CorouselView.m
//  RSStoreKit
//
//  Created by Rao, Venkat on 3/12/15.
//  Copyright (c) 2015 Rao, Venkat. All rights reserved.
//

#import "RSCarouselView.h"

@interface RSCarouselView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSString *carouselCellIdentifier;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation RSCarouselView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.shouldWrapAround = YES;
        
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
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.pageControl];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.pageControl
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0
                                                          constant:0]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]-[pageControl]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"collectionView":self.collectionView,
                                                                               @"pageControl":self.pageControl}]];
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
    }
    return self;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds),
                      CGRectGetHeight(self.collectionView.bounds));
}

-(void) dealloc {
    [self.scrollTimer invalidate];
}

-(void) willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self.scrollTimer invalidate];
    }
}

-(void) scroll {
    NSIndexPath *indexPath = [self indexPathForItemAtCenterOfCollectionView:self.collectionView];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item + 1 inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:YES];
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ([self.dataSource numberOfItemsInCarouselView:self] + (self.shouldWrapAround ? 2 : 0));
}

-(void) collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.shouldWrapAround) {
        return;
    }
    
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
    [self.dataSource configureCell:cell InCarouselView:self atIndex:[self adjustedIndexForCollectionViewIndex:indexPath.item]];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[self.collectionView indexPathForItemAtPoint:scrollView.contentOffset]];
    [self.delegate carouselView:self animationEndedOnCell:cell];
}

-(NSUInteger) adjustedIndexForCollectionViewIndex:(NSUInteger) index {
    
    if (!self.shouldWrapAround) {
        return index;
    }
    
    if (index == 0 || index == ([self.collectionView numberOfItemsInSection:0] - 2)) {
        return ([self.dataSource numberOfItemsInCarouselView:self] - 1);
    } else if (index == 1 || index == ([self.collectionView numberOfItemsInSection:0] - 1)) {
        return 0;
    } else {
        return (index - 1);
    }
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

-(void)setDataSource:(id<RSCarouselViewDataSource>)dataSource {
    _dataSource = dataSource;
    self.pageControl.numberOfPages = [dataSource numberOfItemsInCarouselView:self];
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updatePageControl];
}

-(void) updatePageControl {
    self.pageControl.currentPage = [self adjustedIndexForCollectionViewIndex: [self indexForContentOffset:self.collectionView.contentOffset]];
}

-(NSUInteger) indexForContentOffset:(CGPoint) contentOffset {
    NSUInteger index = 0;
    if (contentOffset.x != 0) {
        index = contentOffset.x / CGRectGetWidth(self.bounds);
    }
    return index;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    NSIndexPath *currentIndexPath = (self.layout.itemSize.width == CGRectGetWidth(self.collectionView.bounds) || self.layout.itemSize.width == CGRectGetHeight(self.collectionView.bounds)) ?
    nil:
    [NSIndexPath indexPathForItem:[self adjustedIndexForCollectionViewIndex:0] inSection:0];
    
    if (currentIndexPath) {
        [self.collectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
}

@end