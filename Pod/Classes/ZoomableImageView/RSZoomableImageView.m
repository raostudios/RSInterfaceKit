//
//  ZoomableScrollView.m
//  Pods
//
//  Created by Venkat Rao on 6/22/15.
//
//

#import "RSZoomableImageView.h"

@interface RSZoomableImageView () <UIScrollViewDelegate>

@property (assign, nonatomic) CGRect oldBounds;

@end

@implementation RSZoomableImageView

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(doubleTapRecognized:)];
        self.doubleTapGestureRecognizer.numberOfTapsRequired = 2;
        [self addGestureRecognizer:self.doubleTapGestureRecognizer];
        
        [self addSubview:self.imageViewFull];
    }
    
    return self;
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

-(void) updateContentSize {
    
    self.contentSize = self.imageViewFull.image.size;
    
    self.minimumZoomScale = MIN(CGRectGetWidth(self.bounds) / self.imageViewFull.image.size.width,
                                CGRectGetHeight(self.bounds) / self.imageViewFull.image.size.height);
    
    self.maximumZoomScale = MAX(self.minimumZoomScale * 2, 1.0);
    
    self.zoomScale = self.minimumZoomScale;
    
    self.imageViewFull.frame = CGRectMake(0.0,
                                          0.0,
                                          self.imageViewFull.image.size.width,
                                          self.imageViewFull.image.size.height);
    
    [self setNeedsLayout];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    [self centerScrollViewContents];
}


-(void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    if (bounds.size.width != self.oldBounds.size.width) {
        [self updateContentSize];
        self.oldBounds = bounds;
    }
}

-(void) doubleTapRecognized:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self setZoomScale:self.minimumZoomScale animated:YES];
}

#pragma mark - UIScrollViewDelegate

-(void) scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollViewContents];
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageViewFull;
}

-(void)setImage:(UIImage *)image {
    self.imageViewFull.image = image;
    [self updateContentSize];
}

-(UIImage *)image {
    return self.imageViewFull.image;
}

#pragma mark - Lazy Instantiation

-(UIImageView *) imageViewFull {
    if (!_imageViewFull) {
        _imageViewFull = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_imageViewFull setContentMode:UIViewContentModeScaleAspectFit];
        [_imageViewFull setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_imageViewFull setUserInteractionEnabled:YES];
    }
    return _imageViewFull;
}

@end
