//
//  ZoomableScrollView.m
//  Pods
//
//  Created by Venkat Rao on 6/22/15.
//
//

#import "RSZoomableImageView.h"

@interface RSZoomableImageView () <UIScrollViewDelegate>

@property (strong, nonatomic) NSLayoutConstraint *imageViewRightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *imageViewLeftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *imageViewTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *imageViewBottomConstraint;

@property (assign, nonatomic) CGSize oldImageSize;

@end

@implementation RSZoomableImageView

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;

        [self addGestureRecognizer:self.doubleTapGestureRecognizer];

        [super addSubview:self.imageViewFull];

        self.imageViewTopConstraint = [self.imageViewFull.topAnchor constraintEqualToAnchor:self.topAnchor];
        self.imageViewLeftConstraint = [self.imageViewFull.leftAnchor constraintEqualToAnchor:self.leftAnchor];
        self.imageViewRightConstraint = [self.imageViewFull.rightAnchor constraintEqualToAnchor:self.rightAnchor];
        self.imageViewBottomConstraint = [self.imageViewFull.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];

        [NSLayoutConstraint activateConstraints:@[self.imageViewTopConstraint, self.imageViewLeftConstraint, self.imageViewRightConstraint, self.imageViewBottomConstraint]];
    }

    return self;
}

-(void)updateZoomBounds {

    CGSize imageSize = self.imageViewFull.image.size;
    
    self.minimumZoomScale = [self minimumZoomScaleForImageSize:imageSize
                                                     andBounds:[self constraintsSize]];
    
    self.maximumZoomScale = MAX(self.minimumZoomScale * 2, 1.0);

    if (!self.doNotChangeScale) {
        self.zoomScale = self.minimumZoomScale;
        [self centerScrollView];
    }
}

-(CGFloat) minimumZoomScaleForImageSize:(CGSize)imageSize andBounds:(CGSize)boundedSize {
    NSAssert(!CGSizeEqualToSize(boundedSize, CGSizeZero), @"rect cannot be empty");
    
    CGFloat ratio = imageSize.width / imageSize.height;
    CGFloat deviceRatio = boundedSize.width / boundedSize.height;
    
    if (ratio > deviceRatio) {
        return (boundedSize.width ) / (imageSize.width );
    } else {
        return (boundedSize.height ) / (imageSize.height );
    }
}

-(void) doubleTapRecognized:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self setZoomScale:self.minimumZoomScale animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)centerScrollView {
    CGFloat horizontalOffset = MAX(0, ([self constraintsSize].width - self.imageViewFull.frame.size.width) / 2);
    self.imageViewLeftConstraint.constant = horizontalOffset;
    self.imageViewRightConstraint.constant = horizontalOffset;

    // vertically center the image view within the scroll view as it zooms.
    CGFloat verticalOffset = MAX(0, ([self constraintsSize].height - self.imageViewFull.frame.size.height) / 2);
    self.imageViewTopConstraint.constant = verticalOffset;
    self.imageViewBottomConstraint.constant = verticalOffset;
}

-(void) scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollView];

    if (scrollView.pinchGestureRecognizer.state == UIGestureRecognizerStateBegan ||
        scrollView.pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        [self.zoomDelegate zoomableImageViewDidZoom:self];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView.panGestureRecognizer.state == UIGestureRecognizerStateBegan ||
        scrollView.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        [self.zoomDelegate zoomableImageViewDidPan:self];
    }
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageViewFull;
}

#pragma mark - Public

-(void) updateImage:(nonnull UIImage *)image shouldUpdateFrame:(BOOL)updateFrames {
    NSParameterAssert(image != nil);
    NSParameterAssert(image.CGImage != nil);

    UIImage *newImage = [UIImage imageWithCGImage:image.CGImage
                                            scale:[UIScreen mainScreen].scale
                                      orientation:image.imageOrientation];

    self.imageViewFull.image = newImage;
    [self.imageViewFull sizeToFit];

    if (CGRectIsEmpty(self.bounds)) {
        return;
    }

    if (updateFrames) {
        [self updateZoomBounds];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (CGRectIsEmpty(self.bounds)) {
        return;
    }

    if (CGSizeEqualToSize(self.imageViewFull.image.size, CGSizeZero)) {
        return;
    }

    if (!CGSizeEqualToSize(self.imageViewFull.image.size, self.oldImageSize)) {
        [self updateZoomBounds];
        self.oldImageSize = self.imageViewFull.image.size;
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

-(UITapGestureRecognizer *)doubleTapGestureRecognizer {
    if(!_doubleTapGestureRecognizer) {
        _doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(doubleTapRecognized:)];
        _doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    }

    return _doubleTapGestureRecognizer;
}

-(CGSize)constraintsSize {
    CGSize constraintedSize = self.bounds.size;

    if (@available(iOS 11, *)) {
        constraintedSize.width -= (self.adjustedContentInset.left + self.adjustedContentInset.right);
        constraintedSize.height -= (self.adjustedContentInset.top + self.adjustedContentInset.bottom);
    } else {
        constraintedSize.width -= (self.contentInset.left + self.contentInset.right);
        constraintedSize.height -= (self.contentInset.top + self.contentInset.bottom);    }

    return constraintedSize;
}

@end
