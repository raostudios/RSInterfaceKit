//
//  ImageView.h
//  Chrytotype
//
//  Created by Rao, Venkat on 11/19/14.
//  Copyright (c) 2014 Venkat Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullImageView : UIView
@property (nonatomic, strong) UIImageView *imageViewFull;
@property (nonatomic, strong) UIButton *buttonDone;
@property (nonatomic, strong) UIView *topView;

-(void) shouldShowButtons:(BOOL) showButtons;

-(void) shouldShowButtons:(BOOL) showButtons animated:(BOOL)animated;

- (void)flipWithAnimation:(BOOL) animated;

@end
