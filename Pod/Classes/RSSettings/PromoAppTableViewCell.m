//
//  PromoAppTableViewCell.m
//  Pods
//
//  Created by Venkat Rao on 7/26/16.
//
//

#import "PromoAppTableViewCell.h"
@import UIKit;

@interface PromoAppTableViewCell ()

@property (nonatomic, strong) UIImageView *imageViewIcon;
@property (nonatomic, strong) UILabel *labelDescription;
@property (nonatomic, strong) UILabel *labelName;


@end

@implementation PromoAppTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.imageViewIcon = [[UIImageView alloc] init];
        self.imageViewIcon.translatesAutoresizingMaskIntoConstraints = NO;
        self.imageViewIcon.clipsToBounds = YES;
        self.imageViewIcon.layer.cornerRadius = 5.0;
        [self.contentView addSubview:self.imageViewIcon];
        
        self.labelDescription = [[UILabel alloc] init];
        self.labelDescription.translatesAutoresizingMaskIntoConstraints = NO;
        self.labelDescription.numberOfLines = 0;
        [self.contentView addSubview:self.labelDescription];
        
        self.labelName = [[UILabel alloc] init];
        self.labelName.translatesAutoresizingMaskIntoConstraints = NO;
        self.labelName.font = [UIFont boldSystemFontOfSize:self.labelName.font.pointSize];
        [self.contentView addSubview:self.labelName];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[imageViewIcon(50)]-[labelName]-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"imageViewIcon": self.imageViewIcon,
                                                                                          @"labelName": self.labelName}]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[imageViewIcon(50)]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:@{@"imageViewIcon": self.imageViewIcon,
                                                                                           @"labelDescription": self.labelDescription}]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[labelName]-(4)-[labelDescription]-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:@{@"imageViewIcon": self.imageViewIcon,
                                                                                           @"labelDescription": self.labelDescription,
                                                                                           @"labelName": self.labelName}]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDescription
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.labelName
                                                                     attribute:NSLayoutAttributeLeading
                                                                    multiplier:1.0
                                                                      constant:0.0]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelDescription]-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:@{@"labelDescription": self.labelDescription}]];
        
    }
    return self;
}

-(void)setAppIcon:(NSString *)appIcon {
    self.imageViewIcon.image = [UIImage imageNamed:appIcon];
}

-(void)setAppName:(NSString *)appName {
    self.labelName.text = appName;
}

-(void)setAppDescription:(NSString *)appDescription {
    self.labelDescription.text = appDescription;
}

@end
