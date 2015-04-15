//
//  RSCarouselImageView.h
//  ImageCarousel
//
//  Created by Venkat Rao on 10/22/13.
//  Copyright (c) 2013 Rao Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSCarouselImageView;

@protocol RSCarouselImageViewDataSource <NSObject>

- (NSInteger) numberOfItemsInCarouselView:(RSCarouselImageView *)carouselView;
- (UIImage *) imageInCarouselView:(RSCarouselImageView *)carouselView atIndex:(NSUInteger)index;

@end

@interface RSCarouselImageView : UIImageView

@property (weak, nonatomic) id<RSCarouselImageViewDataSource> dataSource;
@property (assign, nonatomic) float timeToFade;
@property (assign, nonatomic) float timeToSwitch;

-(void) start;
-(void) stop;

@end
