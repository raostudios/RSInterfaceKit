//
//  SliderActionTableViewCell.m
//  Pods
//
//  Created by Venkat Rao on 7/5/16.
//
//

#import "SliderActionTableViewCell.h"

@implementation SliderActionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self addSubview:self.sliderValue];
        [self addSubview:self.labelName];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[labelName]-[sliderValue]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"sliderValue": self.sliderValue,
                                                                               @"labelName": self.labelName}]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0
                                                          constant:0.0]];
        
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[sliderValue]-(>=8)-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"sliderValue": self.sliderValue,
                                                                               @"labelName": self.labelName}]];
    }
    return self;
}

-(UISlider *)sliderValue {
    if (!_sliderValue) {
        _sliderValue = [UISlider new];
        _sliderValue.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _sliderValue;
}

-(UILabel *)labelName {
    if (!_labelName) {
        _labelName = [UILabel new];
        _labelName.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelName;
}

@end
