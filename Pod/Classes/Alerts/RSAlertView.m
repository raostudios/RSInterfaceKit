//
//  AlertView.m
//  The Big Clock
//
//  Created by Rao, Venkat on 1/1/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "RSAlertView.h"
#import "UIView+AutoLayout.h"

@interface RSAlertView ()

@property (nonatomic, strong) UILabel *labelMessage;
@property (nonatomic, strong) UIButton *buttonClose;

@property (nonatomic, strong) NSLayoutConstraint * constraintHeight;

@property (nonatomic, strong) NSMutableSet *messagesShown;

@end

@implementation RSAlertView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = self.userBackgroundColor;
        
        self.labelMessage = [[UILabel alloc] initWithAutoLayout];
        self.labelMessage.numberOfLines = 0;
        self.labelMessage.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.labelMessage];
        
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *bundleURL = [bundle URLForResource:@"RSInterfaceKit" withExtension:@"bundle"];

        self.buttonClose = [UIButton buttonWithType:UIButtonTypeSystem];
        self.buttonClose.translatesAutoresizingMaskIntoConstraints = NO;
        [self.buttonClose setImage:[[UIImage imageNamed:@"Close" inBundle:[NSBundle bundleWithURL:bundleURL] compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                          forState:UIControlStateNormal];
        self.buttonClose.accessibilityLabel = @"Dismiss Alert";
        [self.buttonClose addTarget:self
                             action:@selector(pressedClose:)
                   forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonClose];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[buttonClose(44)][labelMessage]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"labelMessage":self.labelMessage,
                                                                               @"buttonClose":self.buttonClose}]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMessage
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0
                                                          constant:0.0]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[labelMessage]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"labelMessage":self.labelMessage,
                                                                               @"buttonClose":self.buttonClose}]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.buttonClose
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0]];
        
        self.clipsToBounds = YES;
        
        UITapGestureRecognizer *tapGetureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(alertTapped:)];
        [self addGestureRecognizer:tapGetureRecognizer];
        
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

-(void) alertTapped:(UITapGestureRecognizer *)tapGestures {
    [self.delegate alertViewTapped:self];
}

-(void) dismissPressed:(UIButton *)sender {

}

-(void)setUserBackgroundColor:(UIColor *)backgroundColor {
    self.backgroundColor = backgroundColor;
}

-(UIColor *)userBackgroundColor {
    return self.backgroundColor;
}

-(void)setCloseButtonImage:(UIImage *)closeButtonImage {
    [self.buttonClose setImage:[closeButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                      forState:UIControlStateNormal];
}

-(void)setTextColor:(UIColor *)textColor {
    [self.buttonClose setTintColor:textColor];
    self.labelMessage.textColor = textColor;
}

-(void)setTextFont:(UIFont *)textFont {
    self.labelMessage.font = textFont;
}

-(UIColor *)textColor {
    return self.labelMessage.textColor;
}

-(void) pressedClose:(UIButton *)button {
    if (self.bannerDismissed) {
        self.bannerDismissed();
    }
}

-(NSSet *)messagesShown {
    if (!_messagesShown) {
        _messagesShown = [NSMutableSet new];
    }
    
    return _messagesShown;
}

@end
