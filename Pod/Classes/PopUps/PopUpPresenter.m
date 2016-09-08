//
//  PopUpPresenter.m
//  ToolTip
//
//  Created by Venkat Rao on 2/13/16.
//  Copyright © 2016 Rao Studios. All rights reserved.
//

#import "PopUpPresenter.h"
#import "PopUpView.h"

@import UIKit;

@interface PopUpPresenter ()

@property (nonatomic, strong) UIView *overlay;
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

-(void)popupContainer:(UIView *)container fromBarButtonItem:(UIBarButtonItem *)sender direction:(PopUpDirection)direction {
    UIView *view = [self viewForBarButtonItem:sender];
    [self popupContainer:container fromView:view direction:direction];
}

-(void) popupContainer:(UIView *)container fromView:(UIView *)sender direction:(PopUpDirection)direction {
    
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
    
    NSLayoutAttribute senderTopAttribute;
    NSLayoutAttribute popupTopAttribute;
    NSLayoutAttribute centerAttribute;
    CGFloat centerXOffset = 0.0;

    if(direction == PopUpDirectionUp) {
        senderTopAttribute = NSLayoutAttributeTop;
        popupTopAttribute = NSLayoutAttributeBottom;
        centerAttribute = NSLayoutAttributeCenterX;
        centerXOffset = contentOffset.x;
    } else if(direction == PopUpDirectionDown) {
        senderTopAttribute = NSLayoutAttributeBottom;
        popupTopAttribute = NSLayoutAttributeTop;
        centerAttribute = NSLayoutAttributeCenterX;
        centerXOffset = contentOffset.x;
    } else if(direction == PopUpDirectionRight) {
        senderTopAttribute = NSLayoutAttributeTrailing;
        popupTopAttribute = NSLayoutAttributeLeading;
        centerAttribute = NSLayoutAttributeCenterY;
    } else { //  direction == PopUpDirectionLeft
        senderTopAttribute = NSLayoutAttributeLeading;
        popupTopAttribute = NSLayoutAttributeTrailing;
        centerAttribute = NSLayoutAttributeCenterY;
    }
    
    self.constraintTop = [NSLayoutConstraint constraintWithItem:sender
                                                      attribute:senderTopAttribute
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.toolTip
                                                      attribute:popupTopAttribute
                                                     multiplier:1.0
                                                       constant:contentOffset.y];
    
    [superView addConstraint:self.constraintTop];
    
    NSLayoutConstraint *centerContrstaint = [NSLayoutConstraint constraintWithItem:sender
                                                                         attribute:centerAttribute
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.toolTip
                                                                         attribute:centerAttribute
                                                                        multiplier:1.0
                                                                          constant:centerXOffset];
    centerContrstaint.priority = UILayoutPriorityDefaultLow;
    [superView addConstraint:centerContrstaint];
    
    self.overlay = [[UIView alloc] initWithFrame:CGRectZero];
    self.overlay.translatesAutoresizingMaskIntoConstraints = NO;
    [superView insertSubview:self.overlay belowSubview:self.toolTip];
    
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=8)-[toolTip]-(>=8)-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"toolTip":self.toolTip}]];
    
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[overlay]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"overlay":self.overlay}]];
    
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[overlay]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"overlay":self.overlay}]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide:)];
    [self.overlay addGestureRecognizer:tapGesture];
    
    self.toolTip.offset = [self findOffsetForPopUp:self.toolTip fromSender:sender];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
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

-(CGFloat)findOffsetForPopUp:(UIView *)popUpView fromSender:(UIView *)senderView {
    
    UIView *superview = [self superViewFromView:popUpView];
    
    CGRect popUpRect = [popUpView.superview convertRect:popUpView.frame toView:superview];
    popUpRect.size = [popUpView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];

    CGRect senderRect = [senderView.superview convertRect:senderView.frame toView:superview];

    CGFloat diff = 0.0;
    
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

-(void) hide:(UITapGestureRecognizer *)gesture {
    NSAssert(self.toolTip != nil, @"tooltip cannot be nil");
    
    CGPoint tapLocation = [gesture locationInView:self.overlay];
    CGRect frame = [self.senderView.superview convertRect:self.senderView.frame toView:[self superViewFromView:self.senderView]];

    [self.delegate popUpDismissed:self];

    [self.overlay removeFromSuperview];
    [self.toolTip removeFromSuperview];
    
    UIControl *control;
    if ([self.senderView isKindOfClass:[UIControl class]]) {
        control = (UIControl *)self.senderView;
    }
    UIBarButtonItem *button = self.senderBarButtonItem;
    
    self.senderView = nil;
    self.senderBarButtonItem = nil;
    self.overlay = nil;
    self.toolTip = nil;
    
    if (CGRectContainsPoint(frame, tapLocation)) {
        if (control) {
            [control sendActionsForControlEvents:UIControlEventTouchUpInside];
        } else if(button) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [button.target performSelector:self.senderBarButtonItem.action];
#pragma clang diagnostic pop
        }
    }
    
    
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

@end
