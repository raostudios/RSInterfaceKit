//
//  ZoomableScrollView.h
//  Pods
//
//  Created by Venkat Rao on 6/22/15.
//
//

#import <UIKit/UIKit.h>

@interface RSZoomableImageView : UIScrollView

@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGestureRecognizer;
@property (nonatomic, strong) UIImageView *imageViewFull;
@property (nonatomic, strong) UIImage *image;

-(void)updateImage:(UIImage *)image shouldUpdateFrame:(BOOL)updateFrames;

@end
