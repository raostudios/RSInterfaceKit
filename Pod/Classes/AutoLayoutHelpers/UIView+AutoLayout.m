//
//  UIView+AutoLayout.m
//  The Big Clock
//
//  Created by Rao, Venkat on 12/23/14.
//  Copyright (c) 2014 Venkat Rao. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

-(instancetype) initWithAutoLayout {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

@end
