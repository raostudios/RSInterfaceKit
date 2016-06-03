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

-(void)popUpDismissed:(PopUpPresenter *)popupPresenter;

@end

@interface PopUpPresenter : NSObject

+(PopUpPresenter *)sharedPresentor;

@property (nonatomic, weak) id<PopUpPresenterDelegate> delegate;

-(void) popupContainer:(UIView *)container fromView:(UIView *)sender direction:(PopUpDirection)direction;
-(void) popupContainer:(UIView *)container fromBarButtonItem:(UIBarButtonItem *)sender direction:(PopUpDirection)direction;

@end
