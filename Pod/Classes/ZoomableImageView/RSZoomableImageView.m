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
        
        [super addSubview:self.imageViewFull];
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
    
    CGSize imageSize = self.imageViewFull.image.size;
    
    if (imageSize.width != 0.0 && imageSize.height != 0.0 && CGRectGetHeight(self.bounds) != 0.0) {
        
        self.minimumZoomScale = [self minimumZoomScaleForImageSize:imageSize
                                                    withImageScale:self.imageViewFull.image.scale
                                                         andBounds:self.bounds
                                                         withScale:[UIScreen mainScreen].scale];
        
        self.maximumZoomScale = MAX(self.minimumZoomScale * 2, 1.0);
        
        self.contentSize = imageSize;
        self.zoomScale = self.minimumZoomScale;
        if (self.zoomScale > 1.0) {
            self.contentSize = imageSize;
        }
        
        self.imageViewFull.frame = CGRectMake(0.0,
                                              0.0,
                                              self.contentSize.width,
                                              self.contentSize.height);
        
    }
    
    [self setNeedsLayout];
}

-(CGFloat) minimumZoomScaleForImageSize:(CGSize)imageSize withImageScale:(CGFloat)imageScale andBounds:(CGRect)bounds withScale:(CGFloat)scale {
    
    CGFloat ratio = imageSize.width / imageSize.height;
    CGFloat deviceRatio = CGRectGetWidth(bounds) / CGRectGetHeight(bounds);
    
    if (ratio > deviceRatio) {
        return (CGRectGetWidth(self.bounds) * scale) / (imageSize.width * imageScale);
    } else {
        return (CGRectGetHeight(self.bounds) * scale) / (imageSize.height * imageScale);
    }
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.bounds = self.bounds;
    [self centerScrollViewContents];
}


-(void) setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    if (!CGSizeEqualToSize(bounds.size, self.oldBounds.size)) {
        [self updateContentSize];
        self.oldBounds = bounds;
    }
}

-(void) doubleTapRecognized:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self setZoomScale:self.minimumZoomScale animated:YES];
}

-(void)addSubview:(UIView *)view {
    [self.imageViewFull addSubview:view];
}


#pragma mark - UIScrollViewDelegate

-(void) scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollViewContents];
    [self.zoomDelegate zoomableImageViewDidZoom:self];
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageViewFull;
}

#pragma mark - Public

-(void) updateImage:(nonnull UIImage *)image shouldUpdateFrame:(BOOL)updateFrames {
    NSParameterAssert(image != nil);
    
    UIImage *newImage = [UIImage imageWithCGImage:image.CGImage
                                            scale:[UIScreen mainScreen].scale
                                      orientation:image.imageOrientation];
    
    self.imageViewFull.image = newImage;
    
    if (updateFrames) {
        [self updateContentSize];
    }
}

-(UIImage *) currentImage {
    return self.imageViewFull.image;
}

-(void) prepareForReuse {
    self.imageViewFull.image = nil;
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
