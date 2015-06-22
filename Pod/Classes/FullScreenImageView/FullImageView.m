//
//  ImageView.m
//  Chrytotype
//
//  Created by Rao, Venkat on 11/19/14.
//  Copyright (c) 2014 Venkat Rao. All rights reserved.
//

#import "FullImageView.h"
#import "ZoomableScrollView.h"

@interface FullImageView ()

@property (nonatomic, strong) NSLayoutConstraint *centerY;
@property (nonatomic, strong) NSLayoutConstraint *centerX;


@end

@implementation FullImageView

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.scrollView];
                
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1
                                                          constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1
                                                          constant:0]];
        
        
        [self addSubview:self.buttonDone];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.buttonDone
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailingMargin
                                                        multiplier:1
                                                          constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.buttonDone
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTopMargin
                                                        multiplier:1
                                                          constant:0]];
        self.backgroundColor = [UIColor blackColor];
        
        
    }
    return self;
}

-(UIButton *) buttonDone {
    if (!_buttonDone) {
        _buttonDone = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonDone setTitle:@"Done" forState:UIControlStateNormal];
        [_buttonDone setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _buttonDone;
}

-(UIScrollView *) scrollView {
    if (!_scrollView) {
        _scrollView = [[ZoomableScrollView alloc] initWithFrame:CGRectZero];
        [_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    return _scrollView;
}

-(void) shouldShowButtons:(BOOL) showButtons {
    [self shouldShowButtons:showButtons animated:NO];
}

-(void) shouldShowButtons:(BOOL) showButtons animated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.2 : 0.0 animations:^{
        self.topView.alpha = showButtons ? 1.0 : 0.0;
    }];
}

-(void) flipWithAnimation:(BOOL) animated {
    [self shouldShowButtons:self.buttonDone.alpha == 0.0 animated:animated];
}

-(void) animateBackToOriginalWithCompletion:(void (^)())completionBlock {
    
    [UIView animateWithDuration:.1 animations:^{
        self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
    } completion:^(BOOL finished) {
        if (completionBlock) {
            completionBlock();
        }
    }];
}

@end
