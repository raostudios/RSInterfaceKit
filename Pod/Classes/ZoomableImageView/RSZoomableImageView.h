//
//  ZoomableScrollView.h
//  Pods
//
//  Created by Venkat Rao on 6/22/15.
//
//

#import <UIKit/UIKit.h>

@class RSZoomableImageView;

@protocol RSZoomableImageViewDelegate <NSObject>

-(void)zoomableImageViewDidZoom:(nonnull RSZoomableImageView *)zoomableImageView;

@end

@interface RSZoomableImageView : UIScrollView

@property (nonatomic, strong)  UITapGestureRecognizer * _Nonnull doubleTapGestureRecognizer;
@property (nonatomic, strong) UIImageView * _Nonnull imageViewFull;
@property (nonatomic, weak) id<RSZoomableImageViewDelegate> _Nullable zoomDelegate;

-(void)updateImage:(nonnull UIImage *)image shouldUpdateFrame:(BOOL)updateFrames;
-(nullable UIImage *)currentImage;

-(void)prepareForReuse;

@end
