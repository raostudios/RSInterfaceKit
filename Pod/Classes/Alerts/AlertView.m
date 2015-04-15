//
//  AlertView.m
//  The Big Clock
//
//  Created by Rao, Venkat on 1/1/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "AlertView.h"
#import "UIView+AutoLayout.h"

@interface AlertView ()

@property (nonatomic, strong) UILabel *labelMessage;
@property (nonatomic, strong) UIButton *buttonClose;

@property (nonatomic, strong) NSLayoutConstraint * constraintHeight;

@property (nonatomic, strong) NSMutableSet *messagesShown;

@end

@implementation AlertView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.labelMessage = [[UILabel alloc] initWithAutoLayout];
        self.labelMessage.textColor = [UIColor redColor];
        self.labelMessage.numberOfLines = 0;
        self.labelMessage.textAlignment = NSTextAlignmentCenter;
        self.labelMessage.preferredMaxLayoutWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 44.0;

        [self addSubview:self.labelMessage];
        
        self.buttonClose = [UIButton buttonWithType:UIButtonTypeSystem];
        self.buttonClose.translatesAutoresizingMaskIntoConstraints = NO;
        [self.buttonClose setTitle:@"X" forState:UIControlStateNormal];
        self.buttonClose.accessibilityLabel = @"Dismiss Alert";
        [self.buttonClose addTarget:self action:@selector(pressedClose:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonClose];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[buttonClose(44)][labelMessage]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"labelMessage":self.labelMessage,
                                                                               @"buttonClose":self.buttonClose}]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.labelMessage
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[labelMessage]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"labelMessage": self.labelMessage}]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.buttonClose
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0]];
        
        self.constraintHeight = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:0
                                                          constant:0];
        
        [self addConstraint:self.constraintHeight];
        
        self.clipsToBounds = YES;
    }
    return self;
}

-(NSString *)message {
    return self.labelMessage.text;
}

-(void)setMessage:(NSString *)message {
    self.labelMessage.text = message;
    self.labelMessage.accessibilityLabel = [NSString stringWithFormat:@"Alert: %@", message];
}

-(void) pressedClose:(UIButton *)button {
    [self hideWithAnimation:YES];
}

-(void) showMessage:(NSString *)message withAnimation:(BOOL)animation forced:(BOOL)forced {
    if (![self.messagesShown containsObject:message] || forced) {
        self.message = message;
        [self.messagesShown addObject:message];
        [self.labelMessage sizeToFit];
        self.constraintHeight.constant = CGRectGetHeight(self.labelMessage.frame);
        
        [UIView animateWithDuration:animation ? 0.5f : 0.0f animations:^{
            [self.superview layoutIfNeeded];
        }];
    }
}

-(void) hideWithAnimation:(BOOL)animation {
    self.constraintHeight.constant = 0;
    [UIView animateWithDuration:animation ? 0.5f : 0.0f animations:^{
        [self.superview layoutIfNeeded];
    }];
}

-(NSSet *)messagesShown {
    if (!_messagesShown) {
        _messagesShown = [NSMutableSet new];
    }
    
    return _messagesShown;
}

@end
