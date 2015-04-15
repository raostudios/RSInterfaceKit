//
//  ImageView.m
//  Chrytotype
//
//  Created by Rao, Venkat on 11/19/14.
//  Copyright (c) 2014 Venkat Rao. All rights reserved.
//

#import "FullImageView.h"

@interface FullImageView ()

@property (nonatomic, strong) NSLayoutConstraint *centerY;
@property (nonatomic, strong) NSLayoutConstraint *centerX;

@end

@implementation FullImageView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.imageViewFull];
        self.centerY = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.imageViewFull
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0];
        [self addConstraint:self.centerY];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.imageViewFull
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1
                                                          constant:0]];
        
        self.centerX = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.imageViewFull
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0];
        [self addConstraint:self.centerX];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.imageViewFull
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
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self.imageViewFull addGestureRecognizer:pan];
        
    }
    return self;
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

- (void)pan:(UIPanGestureRecognizer *)panGesture {
    CGPoint point;
    switch (panGesture.state) {
        case UIGestureRecognizerStateChanged:
            point = [panGesture translationInView:self.imageViewFull];
            self.centerX.constant = -point.x;
            self.centerY.constant = -point.y;
            break;
        case UIGestureRecognizerStateEnded: {
            self.centerX.constant = 0;
            self.centerY.constant = 0;
            [UIView animateWithDuration:.2 animations:^{
                [self layoutIfNeeded];
            }];
            } break;
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        default:
            break;
    }
}

@end
