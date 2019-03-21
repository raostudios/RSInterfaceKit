//
//  ZoomableScrollView.h
//  Pods
//
//  Created by Venkat Rao on 6/22/15.
//
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RSZoomableImageView;

@protocol RSZoomableImageViewDelegate <NSObject>

-(void)zoomableImageViewDidZoom:(nonnull RSZoomableImageView *)zoomableImageView;

@optional
-(void)zoomableImageViewDidPan:(nonnull RSZoomableImageView *)zoomableImageView;

@end

@interface RSZoomableImageView : UIScrollView

@property (nonatomic, strong)  UITapGestureRecognizer * _Nonnull doubleTapGestureRecognizer;
@property (nonatomic, strong) UIImageView * _Nonnull imageViewFull;
@property (nonatomic, weak) id<RSZoomableImageViewDelegate> _Nullable zoomDelegate;

@property (nonatomic, assign) BOOL doNotChangeScale;

@property (nonatomic, strong, nullable) UIImage *currentImage;

-(void)updateImage:(nonnull UIImage *)image shouldUpdateFrame:(BOOL)updateFrames;


-(void)prepareForReuse;
-(void)updateZoomBounds;
-(void)centerScrollView;

@end

NS_ASSUME_NONNULL_END
