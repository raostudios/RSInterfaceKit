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
@property (nonatomic, strong) UIColor *colorToUse;

@end

@implementation PopUpView

static const CGFloat height = 10.0;

-(instancetype)initWithContainer:(UIView *)container {
    self = [self initWithFrame:CGRectZero];
    
    if (self) {
        
        self.offset = 90.0f;
        
        [self addSubview:container];
        
        self.colorToUse = container.backgroundColor;
        
        self.leadingContraint = [NSLayoutConstraint constraintWithItem:container
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0
                                                          constant:8];
        
        self.trailingContraint = [NSLayoutConstraint constraintWithItem:self
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:container
                                                            attribute:NSLayoutAttributeTrailing
                                                           multiplier:1.0
                                                             constant:8];
        
        self.topContraint = [NSLayoutConstraint constraintWithItem:container
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:8];
        
        self.bottomContraint = [NSLayoutConstraint constraintWithItem:self
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:container
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:8];
        
        self.cornerRadius = 5.0;
        
        [self addConstraints:@[self.leadingContraint, self.trailingContraint, self.topContraint, self.bottomContraint]];
        self.backgroundColor = [UIColor clearColor];
        container.backgroundColor = [UIColor clearColor];
        
        self.layer.shadowRadius = 6.0;
        self.layer.shadowOffset = CGSizeMake(0, 8.0);
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = .50;
        
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
    
    CGContextSetFillColorWithColor(context, self.colorToUse.CGColor);
    
    CGFloat topHeight = self.direction == PopUpDirectionDown ? height : 0.0;
    CGFloat bottomHeight =  self.direction == PopUpDirectionUp ? height : 0.0;
    CGFloat leadingDistance =  self.direction == PopUpDirectionRight ? height : 0.0;
    CGFloat trailingDistance =  self.direction == PopUpDirectionLeft ? height : 0.0;

    CGContextMoveToPoint(context, leadingDistance, topHeight + self.cornerRadius);
    
    CGContextAddLineToPoint(context, leadingDistance, CGRectGetMidY(self.bounds) - leadingDistance / 2.0);
    CGContextAddLineToPoint(context, 0.0, CGRectGetMidY(self.bounds));
    CGContextAddLineToPoint(context, leadingDistance, CGRectGetMidY(self.bounds) + leadingDistance / 2.0);
    
    CGContextAddLineToPoint(context, leadingDistance, CGRectGetMaxY(self.bounds) - bottomHeight - self.cornerRadius);
    CGContextAddQuadCurveToPoint(context, leadingDistance, CGRectGetMaxY(self.bounds) - bottomHeight, leadingDistance + self.cornerRadius, CGRectGetMaxY(self.bounds) - bottomHeight);
    
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds) - bottomHeight / 2.0 - self.offset, CGRectGetMaxY(self.bounds) - bottomHeight);
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds) - self.offset, CGRectGetMaxY(self.bounds));
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds) + bottomHeight / 2.0 - self.offset, CGRectGetMaxY(self.bounds) - bottomHeight);
    
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - trailingDistance - self.cornerRadius, CGRectGetMaxY(self.bounds) - bottomHeight);
    CGContextAddQuadCurveToPoint(context, CGRectGetMaxX(self.bounds) - trailingDistance, CGRectGetMaxY(self.bounds) - bottomHeight, CGRectGetMaxX(self.bounds) - trailingDistance, CGRectGetMaxY(self.bounds) - bottomHeight -self.cornerRadius);
    
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - trailingDistance, CGRectGetMidY(self.bounds) + trailingDistance / 2.0);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds));
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - trailingDistance, CGRectGetMidY(self.bounds) - trailingDistance / 2.0);
    
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - trailingDistance, topHeight + self.cornerRadius);
    CGContextAddQuadCurveToPoint(context, CGRectGetMaxX(self.bounds) - trailingDistance, topHeight, CGRectGetMaxX(self.bounds) - trailingDistance - self.cornerRadius, topHeight);
    
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds) + topHeight / 2.0, topHeight);
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds), 0.0);
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds) - topHeight / 2.0, topHeight);
    
    CGContextAddLineToPoint(context, self.cornerRadius, topHeight);
    CGContextAddQuadCurveToPoint(context, 0.0, topHeight, leadingDistance, topHeight + self.cornerRadius);
    
    CGContextFillPath(context);
}

@end
