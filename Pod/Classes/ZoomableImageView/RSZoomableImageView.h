//
//  ZoomableScrollView.h
//  Pods
//
//  Created by Venkat Rao on 6/22/15.
//
//

#import <UIKit/UIKit.h>

@interface RSZoomableImageView : UIScrollView

@property (nonatomic, strong)  UITapGestureRecognizer * _Nonnull doubleTapGestureRecognizer;
@property (nonatomic, strong) UIImageView * _Nonnull imageViewFull;

-(void)updateImage:(nonnull UIImage *)image shouldUpdateFrame:(BOOL)updateFrames;
-(nullable UIImage *)currentImage;

-(void)prepareForReuse;

@end
