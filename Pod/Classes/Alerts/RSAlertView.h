//
//  AlertView.h
//  The Big Clock
//
//  Created by Rao, Venkat on 1/1/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSAlertView;

@protocol RSAlertViewDelegate <NSObject>

-(void) alertViewTapped:(RSAlertView *)alertView;

@end

@interface RSAlertView : UIView <UIAppearanceContainer>

@property (nonatomic, weak) NSString *message;

@property (nonatomic, copy) void(^bannerDismissed)(void);

@property (nonatomic, weak) id<RSAlertViewDelegate> delegate;

@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *userBackgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIImage *closeButtonImage UI_APPEARANCE_SELECTOR;

@end
