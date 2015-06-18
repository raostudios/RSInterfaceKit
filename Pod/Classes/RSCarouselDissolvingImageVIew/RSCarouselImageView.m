//
//  RSCarouselImageView.m
//  ImageCarousel
//
//  Created by Venkat Rao on 10/22/13.
//  Copyright (c) 2013 Rao Studios. All rights reserved.
//

#import "RSCarouselImageView.h"

@interface RSCarouselImageView ()

@property (strong, nonatomic) NSTimer * timer;
@property (assign, nonatomic) NSInteger index;

@end

@implementation RSCarouselImageView

-(void) updateImage {

    __weak RSCarouselImageView * weakSelf = self;
    dispatch_queue_t queue = dispatch_queue_create("queens.org", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        if (self.index >= [self.dataSource numberOfItemsInCarouselView:self]) {
            self.index = 0;
        }
        UIImage * setimage = [weakSelf.dataSource imageInCarouselView:self atIndex:self.index];
        dispatch_async(dispatch_get_main_queue(), ^{

        [UIView transitionWithView:self
                          duration:self.timeToFade ?: 1.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{

                                [weakSelf setImage:setimage];
                            
                        } completion:^(BOOL finished) {
                            self.index++;
                            
                        }];
        });

    });

}

-(void)setDataSource:(id<RSCarouselImageViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self setImage:[dataSource imageInCarouselView:self atIndex:self.index]];
    self.index = 1;
}

-(void) start {
    [self.timer invalidate];
    self. timer = [NSTimer scheduledTimerWithTimeInterval:self.timeToSwitch ?: 5.0
                                                       target:self
                                                     selector:@selector(updateImage)
                                                     userInfo:nil
                                                      repeats:YES];
}

-(void) stop {

    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
