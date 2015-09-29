//
//  ViewController.h
//  CollectionViewTest
//
//  Created by Venkat Rao on 8/3/15.
//  Copyright (c) 2015 Rao Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionViewWithTransitionsDataSource <UICollectionViewDataSource>

-(instancetype) initWithCollectionView:(UICollectionView *)collectionView;
-(void) setCollectionView:(UICollectionView *)collectionView;

@end

@interface CollectionViewWithTransitions : UICollectionViewController

@property (nonatomic, strong) id<CollectionViewWithTransitionsDataSource> dataSource;

@end

