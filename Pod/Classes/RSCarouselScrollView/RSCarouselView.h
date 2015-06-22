//
//  CorouselView.h
//  RSStoreKit
//
//  Created by Rao, Venkat on 3/12/15.
//  Copyright (c) 2015 Rao, Venkat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSCarouselView;

@protocol RSCarouselViewDataSource <NSObject>

-(NSInteger) numberOfItemsInCarouselView:(RSCarouselView *)carouselView;
-(void) configureCell:(UICollectionViewCell *)cell InCarouselView:(RSCarouselView *)carouselView atIndex:(NSUInteger)index;

@end

@interface RSCarouselView : UIView

@property (nonatomic, weak) id<RSCarouselViewDataSource> dataSource;
@property (nonatomic, strong) NSTimer *scrollTimer;

-(void) registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

-(void) start;
-(void) stop;

@end
