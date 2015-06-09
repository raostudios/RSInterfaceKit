//
//  ImageView.m
//  Chrytotype
//
//  Created by Rao, Venkat on 11/19/14.
//  Copyright (c) 2014 Venkat Rao. All rights reserved.
//

#import "FullImageView.h"

@interface FullImageView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSLayoutConstraint *centerY;
@property (nonatomic, strong) NSLayoutConstraint *centerX;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation FullImageView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.scrollView];
        
        [self.scrollView addSubview:self.imageViewFull];
        
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

-(void)updateContentSize {
    
    self.scrollView.contentSize = self.imageViewFull.image.size;
    
    self.scrollView.minimumZoomScale = MIN(CGRectGetWidth([UIScreen mainScreen].bounds) / self.imageViewFull.image.size.width,
                                           CGRectGetHeight([UIScreen mainScreen].bounds) / self.imageViewFull.image.size.height);
    
    self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
    
    self.imageViewFull.frame = CGRectMake(0.0,
                                          0.0,
                                          self.imageViewFull.image.size.width,
                                          self.imageViewFull.image.size.height);
    
    [self centerScrollViewContents];
}

-(UIButton *)buttonDone {
    if (!_buttonDone) {
        _buttonDone = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonDone setTitle:@"Done" forState:UIControlStateNormal];
        [_buttonDone setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _buttonDone;
}

-(UIImageView *)imageViewFull {
    if (!_imageViewFull) {
        _imageViewFull = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandH.jpg"]];
        [_imageViewFull setContentMode:UIViewContentModeScaleAspectFit];
        [_imageViewFull setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_imageViewFull setUserInteractionEnabled:YES];
    }
    return _imageViewFull;
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.minimumZoomScale=0.1;
        _scrollView.maximumZoomScale=1.0;
    }
    
    return _scrollView;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageViewFull;
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageViewFull.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageViewFull.frame = contentsFrame;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollViewContents];
}

-(void) shouldShowButtons:(BOOL) showButtons {
    [self shouldShowButtons:showButtons animated:NO];
}

-(void) shouldShowButtons:(BOOL) showButtons animated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.2 : 0.0 animations:^{
        self.topView.alpha = showButtons ? 1.0 : 0.0;
    }];
}

- (void)flipWithAnimation:(BOOL) animated {
    [self shouldShowButtons:self.buttonDone.alpha == 0.0 animated:animated];
}

@end
