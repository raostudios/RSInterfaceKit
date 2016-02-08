//
//  SettingsHeaderView.m
//  Pods
//
//  Created by Venkat Rao on 2/7/16.
//
//

#import "SettingsHeaderView.h"

@interface SettingsHeaderView ()

@property (nonatomic, strong) UIImageView *imageViewLogo;
@property (nonatomic, strong) UILabel *labelText;

@end

@implementation SettingsHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.imageViewLogo];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageViewLogo
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0
                                                          constant:0.0]];
        
        [self addSubview:self.labelText];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[labelText]"
                                                                   options:0
                                                                   metrics:nil
                                                                      views:@{@"labelText": self.labelText}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[imageViewLogo]-[labelText]-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:@{@"labelText": self.labelText,
                                                                              @"imageViewLogo": self.imageViewLogo}]];
    }
    return self;
}

-(void)setImageLogo:(UIImage *)imageLogo {
    self.imageViewLogo.image = imageLogo;
}

-(void)setText:(NSString *)text {
    self.labelText.text = text;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.labelText.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds) - 16;
}

-(CGRect) frameForHeaderForMaxWidth:(CGFloat)maxWidth {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *headerWidthConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1.0f
                                                                              constant:maxWidth];
    
    [self addConstraint:headerWidthConstraint];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGSize newSize = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    [self removeConstraint:headerWidthConstraint];
    CGRect newFrame = CGRectMake(0, 0, newSize.width, newSize.height);
    self.translatesAutoresizingMaskIntoConstraints = YES;
    return newFrame;
}

#pragma mark - Lazy Instantiation

-(UIImageView *)imageViewLogo {
    if (!_imageViewLogo) {
        _imageViewLogo = [UIImageView new];
        _imageViewLogo.translatesAutoresizingMaskIntoConstraints = NO;
        _imageViewLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageViewLogo;
}

-(UILabel *)labelText {
    if (!_labelText) {
        _labelText = [UILabel new];
        _labelText.translatesAutoresizingMaskIntoConstraints = NO;
        _labelText.numberOfLines = 0;
        _labelText.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _labelText;
}

@end
