//
//  RSInterfaceKitLibraryView.m
//  RSInterfaceKit
//
//  Created by Venkat Rao on 6/7/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "RSInterfaceKitLibraryView.h"

@implementation RSInterfaceKitLibraryView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.tableViewItems = [[UITableView alloc] initWithFrame:CGRectZero];
        self.tableViewItems.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.tableViewItems];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableViewItems]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"tableViewItems": self.tableViewItems}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableViewItems]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"tableViewItems": self.tableViewItems}]];
    }
    
    return self;
}

@end
