//
//  PopUpPresenter.h
//  ToolTip
//
//  Created by Venkat Rao on 2/13/16.
//  Copyright © 2016 Rao Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PopUpView.h"

@class UIView;
@class PopUpPresenter;

@protocol PopUpPresenterDelegate <NSObject>

-(void)popUpDismissed:(PopUpPresenter * _Nonnull)popupPresenter;

@end

@interface PopUpPresenter : NSObject

+(PopUpPresenter * _Nonnull)sharedPresentor;

@property (nonatomic, weak) id<PopUpPresenterDelegate> _Nullable delegate;

-(void) popupContainer:(UIView * _Nonnull)container fromView:(UIView * _Nonnull)sender direction:(PopUpDirection)direction;
-(void) popupContainer:(UIView * _Nonnull)container fromBarButtonItem:(UIBarButtonItem * _Nonnull)sender direction:(PopUpDirection)direction;

-(void)hidePopup;

@end
