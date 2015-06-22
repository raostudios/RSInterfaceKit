//
//  ZoomableScrollView.m
//  Pods
//
//  Created by Venkat Rao on 6/22/15.
//
//

#import "ZoomableScrollView.h"

@interface ZoomableScrollView () <UIScrollViewDelegate>

@end

@implementation ZoomableScrollView

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.minimumZoomScale=0.1;
        self.maximumZoomScale=1.0;
        
        [self addSubview:self.imageViewFull];
    }
    
    return self;
}
    

-(UIImageView *) imageViewFull {
    if (!_imageViewFull) {
        _imageViewFull = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_imageViewFull setContentMode:UIViewContentModeScaleAspectFit];
        [_imageViewFull setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_imageViewFull setUserInteractionEnabled:YES];
    }
    return _imageViewFull;
}


-(void) centerScrollViewContents {
    CGSize boundsSize = self.bounds.size;
    CGRect contentsFrame = self.imageViewFull.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageViewFull.frame = contentsFrame;
}

-(void) scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollViewContents];
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageViewFull;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    
    [self centerScrollViewContents];
}


-(void) updateContentSize {
    
    self.contentSize = self.imageViewFull.image.size;
    
    self.minimumZoomScale = MIN(CGRectGetWidth([UIScreen mainScreen].bounds) / self.imageViewFull.image.size.width,
                                           CGRectGetHeight([UIScreen mainScreen].bounds) / self.imageViewFull.image.size.height);
    
    self.zoomScale = self.minimumZoomScale;
    
    self.imageViewFull.frame = CGRectMake(0.0,
                                          0.0,
                                          self.imageViewFull.image.size.width,
                                          self.imageViewFull.image.size.height);
    
    [self setNeedsLayout];
}

@end
