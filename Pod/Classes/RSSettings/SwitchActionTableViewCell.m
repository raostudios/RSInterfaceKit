//
//  SwitchActionTableViewCell.m
//  Pods
//
//  Created by Venkat Rao on 7/5/16.
//
//

#import "SwitchActionTableViewCell.h"

@implementation SwitchActionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self addSubview:self.switchValue];
        [self addSubview:self.labelName];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[labelName]-[switchValue]-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:@{@"switchValue": self.switchValue,
                                                                              @"labelName": self.labelName}]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0
                                                          constant:0.0]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[switchValue]-(>=8)-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"switchValue": self.switchValue,
                                                                               @"labelName": self.labelName}]];
    }
    return self;
}

-(UISwitch *)switchValue {
    if (!_switchValue) {
        _switchValue = [UISwitch new];
        _switchValue.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _switchValue;
}

-(UILabel *)labelName {
    if (!_labelName) {
        _labelName = [UILabel new];
        _labelName.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelName;
}

@end
