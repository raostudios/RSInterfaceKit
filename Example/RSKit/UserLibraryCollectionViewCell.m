//
//  UserLibraryCollectionViewCell.m
//  Animatic
//
//  Created by Venkat Rao on 5/31/15.
//  Copyright (c) 2015 Animatic. All rights reserved.
//

#import "UserLibraryCollectionViewCell.h"


@implementation UserLibraryCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.imageViewThumbnail = [[UIImageView alloc] init];
        self.imageViewThumbnail.translatesAutoresizingMaskIntoConstraints = NO;
        self.imageViewThumbnail.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewThumbnail.clipsToBounds = YES;
        [self.contentView addSubview:self.imageViewThumbnail];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageViewThumbnail]|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"imageViewThumbnail": self.imageViewThumbnail}]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageViewThumbnail]|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:@{@"imageViewThumbnail": self.imageViewThumbnail}]];
        
    }
    return self;
}

@end
