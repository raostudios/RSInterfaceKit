//
//  ZoomableScrollView.h
//  Pods
//
//  Created by Venkat Rao on 6/22/15.
//
//

#import <UIKit/UIKit.h>

@interface ZoomableScrollView : UIScrollView

@property (nonatomic, strong) UIImageView *imageViewFull;

- (void)updateContentSize;

@end
