//
//  AlbumSelectorView.m
//  Preset
//
//  Created by Venkat Rao on 4/6/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import "MenuSelectorView.h"

@implementation MenuSelectorView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.overlayView = [[UIView alloc] initWithFrame:CGRectZero];
        self.overlayView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.overlayView];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        self.tableView.estimatedRowHeight = 100.0;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self addSubview:self.tableView];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];

        self.constraintHeight = [NSLayoutConstraint constraintWithItem:self.tableView
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:0.0
                                                              constant:0.0];
        [self addConstraint:self.constraintHeight];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:0.0
                                                              constant:320.0]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[overlayView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"overlayView": self.overlayView}]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[overlayView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"overlayView": self.overlayView}]];
        
    }
    return self;
}

-(void)setOverlayBackgroundColor:(UIColor *)overlayBackgroundColor {
    self.tableView.backgroundColor = overlayBackgroundColor;
}

@end
