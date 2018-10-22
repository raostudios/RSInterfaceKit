//
//  PopUpPresenter.m
//  ToolTip
//
//  Created by Venkat Rao on 2/13/16.
//  Copyright © 2016 Rao Studios. All rights reserved.
//

#import "PopUpPresenter.h"
#import "PopupBackgroundView.h"
#import "PopUpView.h"

@import UIKit;

@interface PopUpPresenter ()<PopupBackgroundViewDelegate>

@property (nonatomic, strong) PopupBackgroundView *overlay;
@property (nonatomic, strong) PopUpView *toolTip;
@property (nonatomic, strong) UIView *senderView;
@property (nonatomic, strong) UIBarButtonItem *senderBarButtonItem;

@property (nonatomic, strong) NSLayoutConstraint *constraintTop;

@end

@implementation PopUpPresenter

+(PopUpPresenter *)sharedPresentor {
    static PopUpPresenter *popUpPresenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        popUpPresenter = [PopUpPresenter new];
    });
    return popUpPresenter;
}

- (UIToolbar *)findToolbar:(UIView *)view {
    NSAssert(view, @"view cannot be nil");
    
    UIView *toolbar = view;
    while (![toolbar isKindOfClass:[UIToolbar class]] && toolbar != nil) {
        toolbar = toolbar.superview;
    }
    return (UIToolbar *)toolbar;
}

-(void)popupContainer:(UIView *)container fromBarButtonItem:(UIBarButtonItem *)sender direction:(PopUpDirection)direction {
    UIView *view = [self viewForBarButtonItem:sender];
    UIToolbar * toolbar = [self findToolbar:view];

    CGRect new = [view.superview convertRect:view.frame toView:toolbar];
    CGFloat offset = CGRectGetMidX(toolbar.frame) - CGRectGetMidX(new);
    
    [self popupContainer:container fromView:toolbar direction:direction withOffset:CGPointMake(offset, 0.0)];
}

-(void) popupContainer:(UIView *)container fromView:(UIView *)sender direction:(PopUpDirection)direction {
    [self popupContainer:container fromView:sender direction:direction withOffset:CGPointZero];
}

- (void)addMotionEffect {
    UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                                          type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-10);
    horizontalMotionEffect.maximumRelativeValue = @(10);
    
    UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                                                        type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-10);
    verticalMotionEffect.maximumRelativeValue = @(10);
    
    UIInterpolatingMotionEffect *shadowEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"layer.shadowOffset"
                                                                                                type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    
    shadowEffect.minimumRelativeValue = [NSValue valueWithCGSize:CGSizeMake(-10, 8.0)];
    shadowEffect.maximumRelativeValue = [NSValue valueWithCGSize:CGSizeMake(10, 8.0)];
    
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect, shadowEffect];
    
    [self.toolTip addMotionEffect:group];
}

- (void)addKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)addOverlay:(UIView *)superView {
    self.overlay = [[PopupBackgroundView alloc] initWithFrame:CGRectZero];
    self.overlay.translatesAutoresizingMaskIntoConstraints = NO;
    self.overlay.delegate = self;
    
    [superView insertSubview:self.overlay belowSubview:self.toolTip];
    
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[overlay]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"overlay":self.overlay}]];
    
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[overlay]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"overlay":self.overlay}]];
}

- (void)createConstraintsWithOffset:(CGPoint)contentOffset direction:(PopUpDirection)direction offset:(CGPoint)offset sender:(UIView *)sender superView:(UIView *)superView {
    
    NSLayoutAnchor *senderTopAnchor;
    NSLayoutAnchor *popupTopAnchor;
    
    NSLayoutAttribute centerAttribute;
    CGFloat centerXOffset = offset.x;
    
    if(direction == PopUpDirectionUp) {
        senderTopAnchor = sender.topAnchor;
        popupTopAnchor = self.toolTip.bottomAnchor;
        centerAttribute = NSLayoutAttributeCenterX;
        centerXOffset += contentOffset.x;
    } else if(direction == PopUpDirectionDown) {
        senderTopAnchor = sender.bottomAnchor;
        popupTopAnchor = self.toolTip.topAnchor;
        centerAttribute = NSLayoutAttributeCenterX;
        centerXOffset += contentOffset.x;
    } else if(direction == PopUpDirectionRight) {
        senderTopAnchor = sender.trailingAnchor;
        popupTopAnchor = self.toolTip.leadingAnchor;
        centerAttribute = NSLayoutAttributeCenterY;
    } else { //  direction == PopUpDirectionLeft
        senderTopAnchor = sender.leadingAnchor;
        popupTopAnchor = self.toolTip.trailingAnchor;
        centerAttribute = NSLayoutAttributeCenterY;
    }
    
    NSLayoutConstraint *centerConstraint = [NSLayoutConstraint constraintWithItem:sender
                                                                        attribute:centerAttribute
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.toolTip
                                                                        attribute:centerAttribute
                                                                       multiplier:1.0
                                                                         constant:centerXOffset];
    
    [popupTopAnchor constraintEqualToAnchor:senderTopAnchor constant:contentOffset.y].active = YES;
    
    
    centerConstraint.priority = UILayoutPriorityDefaultLow;
    [superView addConstraint:centerConstraint];
    
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=8)-[toolTip]-(>=8)-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"toolTip":self.toolTip}]];
}

-(void) popupContainer:(UIView *)container fromView:(UIView *)sender direction:(PopUpDirection)direction withOffset:(CGPoint)offset {
    
    NSAssert(sender, @"sender cannot be nil");
    NSAssert(container, @"container cannot be nil");

    self.senderView = sender;
    UIView *superView = [self superViewFromView:sender];
    
    self.toolTip = [[PopUpView alloc] initWithContainer:container];
    
    if (direction == PopUpDirectionAuto) {
        direction = [self directionForPopup:self.toolTip fromSender:sender];
    }
    
    self.toolTip.direction = direction;
    
    self.toolTip.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:self.toolTip];
    
    CGPoint contentOffset = CGPointZero;
    UIView *newScrollView = sender.superview;
    
    while (newScrollView) {
        if ([newScrollView isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)newScrollView;
            contentOffset.x += scrollView.contentOffset.x;
            contentOffset.y += scrollView.contentOffset.y;
        }
        newScrollView = newScrollView.superview;
    }
    
    [self createConstraintsWithOffset:contentOffset direction:direction offset:offset sender:sender superView:superView];
    
    [superView layoutIfNeeded];
    
    CGRect rect = [superView convertRect:sender.frame fromView:sender.superview];
    
    CGFloat current = CGRectGetMidX(rect) - CGRectGetMidX(self.toolTip.frame);
    
    self.toolTip.offset = [self findOffsetForPopUp:self.toolTip fromSender:sender withInitialOffset:CGPointMake(offset.x - current, 0.0)];
    
    [self addOverlay:superView];
    [self addKeyboardNotifications];
    [self addMotionEffect];
}

-(CGFloat)findOffsetForPopUp:(UIView *)popUpView fromSender:(UIView *)senderView withInitialOffset:(CGPoint)initialOffset {
    
    if ([senderView isKindOfClass:[UIToolbar class]]) {
        return initialOffset.x;
    }
    
    UIView *superview = [self superViewFromView:popUpView];
    
    CGRect popUpRect = [popUpView.superview convertRect:popUpView.frame toView:superview];
    popUpRect.size = [popUpView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];

    CGRect senderRect = [senderView.superview convertRect:senderView.frame toView:superview];

    CGFloat diff = initialOffset.x;
    
    if (CGRectGetMidX(senderRect) + (CGRectGetMidX(popUpRect) + 8.0) > CGRectGetWidth(superview.frame)) {
        diff = CGRectGetWidth(superview.frame) - CGRectGetMidX(senderRect) - (CGRectGetMidX(popUpRect) + 8.0);
    } else if (CGRectGetMidX(senderRect) - (CGRectGetMidX(popUpRect) + 8.0)  < 0.0){
        diff = fabs(CGRectGetMidX(senderRect) - (CGRectGetMidX(popUpRect) + 8.0));
    }
    
    return diff;
}

-(PopUpDirection) directionForPopup:(UIView *)popup fromSender:(UIView *)sender {
 
    UIView *superview = [self superViewFromView:sender];
    CGRect rect = superview.frame;
    
    CGRect newSenderRect = sender.frame;
    newSenderRect.origin = [superview convertPoint:rect.origin fromView:sender];

    CGFloat topMax = CGRectGetHeight(rect) - CGRectGetMaxY(newSenderRect);
    CGFloat bottom = CGRectGetMinY(newSenderRect);
    
    if (topMax > bottom) {
        return PopUpDirectionDown;
    } else {
        return PopUpDirectionUp;
    }
}


-(void)hidePopup {
    [self.delegate popUpDismissed:self];
    
    self.senderView = nil;
    self.senderBarButtonItem = nil;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.overlay removeFromSuperview];
        self.overlay = nil;
//    });
    
    [self.toolTip removeFromSuperview];
    
    self.toolTip = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

-(void) keyboardDidShow:(NSNotification *) notification {
    UIView *sender = self.constraintTop.firstItem;
    
    UIView *superview = [self superViewFromView:sender];
    CGRect newSenderRect = sender.frame;
    newSenderRect.origin = [superview convertPoint:sender.frame.origin fromView:sender];
    
    self.constraintTop.constant = MAX(0.0, CGRectGetMinY(newSenderRect) - CGRectGetMinY([notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]));
}

-(void) keyboardDidHide:(NSNotification *) notification {
    self.constraintTop.constant = 0.0;
}

-(UIView *) superViewFromView:(UIView *)view {
    
    if ([view isKindOfClass:[UIBarButtonItem class]]) {
        view = [self viewForBarButtonItem:(UIBarButtonItem *)view];
    }
    
    UIView *superView = view;
    while (superView.superview) {
        superView = superView.superview;
    }
    return superView;
}

-(UIView *)viewForBarButtonItem:(UIBarButtonItem *)barButtonItem {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    UIView *view = [barButtonItem performSelector:@selector(view)];
#pragma clang diagnostic pop
    
    return view;
}

-(void)dismissPopUpForBackgroundView:(PopupBackgroundView *)popupBackgroundView {
    [self hidePopup];
}

@end
