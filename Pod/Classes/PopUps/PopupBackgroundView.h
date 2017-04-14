//
//  PopupBackgroundView.h
//  Pods
//
//  Created by Venkat Rao on 4/14/17.
//
//

#import <UIKit/UIKit.h>

@class PopupBackgroundView;

@protocol PopupBackgroundViewDelegate <NSObject>

-(void)dismissPopUpForBackgroundView:(PopupBackgroundView *)popupBackgroundView;

@end

@interface PopupBackgroundView : UIView

@property (nonatomic, weak) id<PopupBackgroundViewDelegate> delegate;

@end
