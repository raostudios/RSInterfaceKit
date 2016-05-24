//
//  ToolTip.m
//  ToolTip
//
//  Created by Venkat Rao on 2/13/16.
//  Copyright © 2016 Rao Studios. All rights reserved.
//

#import "PopUpView.h"

@interface PopUpView()

@property (nonatomic, strong) UIView *viewContainer;
@property (nonatomic, strong) NSLayoutConstraint *topContraint;
@property (nonatomic, strong) NSLayoutConstraint *bottomContraint;
@property (nonatomic, strong) NSLayoutConstraint *leadingContraint;
@property (nonatomic, strong) NSLayoutConstraint *trailingContraint;

@end

@implementation PopUpView

static const CGFloat height = 10.0;

-(instancetype)initWithContainer:(UIView *)containter {
    self = [self initWithFrame:CGRectZero];
    
    if (self) {
        
        self.offset = 90.0f;
        
        [self addSubview:containter];
        
        self.leadingContraint = [NSLayoutConstraint constraintWithItem:containter
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0
                                                          constant:8];
        
        self.trailingContraint = [NSLayoutConstraint constraintWithItem:self
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:containter
                                                            attribute:NSLayoutAttributeTrailing
                                                           multiplier:1.0
                                                             constant:8];
        
        self.topContraint = [NSLayoutConstraint constraintWithItem:containter
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:8];
        
        self.bottomContraint = [NSLayoutConstraint constraintWithItem:self
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:containter
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:8];
        
        [self addConstraints:@[self.leadingContraint, self.trailingContraint, self.topContraint, self.bottomContraint]];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setDirection:(PopUpDirection)direction {
    _direction = direction;
    
    self.topContraint.constant = 8;
    self.bottomContraint.constant = 8;
    self.leadingContraint.constant = 8;
    self.trailingContraint.constant = 8;
    
    if (_direction == PopUpDirectionUp) {
        self.bottomContraint.constant += height;
    } else if (_direction == PopUpDirectionDown) {
        self.topContraint.constant += height;
    } else if (_direction == PopUpDirectionRight) {
        self.leadingContraint.constant += height;
    } else if (_direction == PopUpDirectionLeft) {
        self.trailingContraint.constant += height;
    }
}

-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] colorWithAlphaComponent:.6].CGColor);
    
    CGFloat topHeight = self.direction == PopUpDirectionDown ? height : 0.0;
    CGFloat bottomHeight =  self.direction == PopUpDirectionUp ? height : 0.0;
    CGFloat leadingDistance =  self.direction == PopUpDirectionRight ? height : 0.0;
    CGFloat trailingDistance =  self.direction == PopUpDirectionLeft ? height : 0.0;

    
    CGContextMoveToPoint(context, leadingDistance, topHeight);
    
    CGContextAddLineToPoint(context, leadingDistance, CGRectGetMidY(self.bounds) - leadingDistance / 2.0);
    CGContextAddLineToPoint(context, 0.0, CGRectGetMidY(self.bounds));
    CGContextAddLineToPoint(context, leadingDistance, CGRectGetMidY(self.bounds) + leadingDistance / 2.0);
    
    CGContextAddLineToPoint(context, leadingDistance, CGRectGetMaxY(self.bounds) - bottomHeight);
    
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds) - bottomHeight / 2.0 - self.offset, CGRectGetMaxY(self.bounds) - bottomHeight);
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds) - self.offset, CGRectGetMaxY(self.bounds));
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds) + bottomHeight / 2.0 - self.offset, CGRectGetMaxY(self.bounds) - bottomHeight);
    
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - trailingDistance, CGRectGetMaxY(self.bounds) - bottomHeight);
    
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - trailingDistance, CGRectGetMidY(self.bounds) + trailingDistance / 2.0);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds));
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - trailingDistance, CGRectGetMidY(self.bounds) - trailingDistance / 2.0);
    
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - trailingDistance, topHeight);
    
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds) + topHeight / 2.0, topHeight);
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds), 0.0);
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds) - topHeight / 2.0, topHeight);
    
    CGContextAddLineToPoint(context, 0, topHeight);
    
    CGContextFillPath(context);
}

@end
