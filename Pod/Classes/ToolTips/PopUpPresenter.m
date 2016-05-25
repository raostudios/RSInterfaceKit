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
    UIView *view = [sender performSelector:@selector(view)];
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
    
    NSLayoutAttribute senderTopAttribute;
    NSLayoutAttribute popupTopAttribute;
    NSLayoutAttribute centerAttribute;

    if(direction == PopUpDirectionUp) {
        senderTopAttribute = NSLayoutAttributeTop;
        popupTopAttribute = NSLayoutAttributeBottom;
        centerAttribute = NSLayoutAttributeCenterX;
    } else if(direction == PopUpDirectionDown) {
        senderTopAttribute = NSLayoutAttributeBottom;
        popupTopAttribute = NSLayoutAttributeTop;
        centerAttribute = NSLayoutAttributeCenterX;
    } else if(direction == PopUpDirectionRight) {
        senderTopAttribute = NSLayoutAttributeTrailing;
        popupTopAttribute = NSLayoutAttributeLeading;
        centerAttribute = NSLayoutAttributeCenterY;
    } else { //  direction == PopUpDirectionLeft
        senderTopAttribute = NSLayoutAttributeLeading;
        popupTopAttribute = NSLayoutAttributeTrailing;
        centerAttribute = NSLayoutAttributeCenterY;
    }
    
    NSLayoutConstraint *centerContrstaint = [NSLayoutConstraint constraintWithItem:sender
                                                                         attribute:centerAttribute
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.toolTip
                                                                         attribute:centerAttribute
                                                                        multiplier:1.0
                                                                          constant:0];
    centerContrstaint.priority = UILayoutPriorityDefaultLow;
    
    [superView addConstraint:centerContrstaint];
    
    self.constraintTop = [NSLayoutConstraint constraintWithItem:sender
                                                      attribute:senderTopAttribute
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.toolTip
                                                      attribute:popupTopAttribute
                                                     multiplier:1.0
                                                       constant:0];
    
    [superView addConstraint:self.constraintTop];
    
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
    
    self.toolTip.offset = [self findOffsetForSender:self.toolTip fromSender:sender];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];

}

-(CGFloat)findOffsetForSender:(UIView *)view fromSender:(UIView *)senderView {
    
    UIView *superview = [self superViewFromView:view];
    
    CGRect newSenderRect = view.frame;
    newSenderRect.size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];

    CGRect senderRect = senderView.frame;
    senderRect.origin = [superview convertPoint:senderView.frame.origin fromView:senderView];

    CGFloat diff = CGRectGetMidX(senderRect) - CGRectGetMidX(newSenderRect) - 8.0;
    
    return diff < 0 ? fabs(diff) : 0.0;
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
    
    CGPoint tapLocation = [gesture locationInView:self.overlay];
    CGRect frame = [self.senderView.superview convertRect:self.senderView.frame toView:[self superViewFromView:self.senderView]];
    if (CGRectContainsPoint(frame, tapLocation)) {
        if ([self.senderView isKindOfClass:[UIControl class]]) {
            UIControl *control = (UIControl *)self.senderView;
            [control sendActionsForControlEvents:UIControlEventTouchUpInside];
        } else if(self.senderBarButtonItem) {
            [self.senderBarButtonItem.target performSelector:self.senderBarButtonItem.action];
        }
    } else {
        [self.delegate popUpDismissed:self];
    }

    [self.overlay removeFromSuperview];
    [self.toolTip removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
    self.senderView = nil;
    self.senderBarButtonItem = nil;
    self.toolTip = nil;
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
        view = [view performSelector:@selector(view)];
    }
    
    UIView *superView = view;
    while (superView.superview) {
        superView = superView.superview;
    }
    return superView;
}

@end
