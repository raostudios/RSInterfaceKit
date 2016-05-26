//
//  AlbumSelectorView.h
//  Preset
//
//  Created by Venkat Rao on 4/6/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuSelectorView : UIView<UIAppearanceContainer>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *overlayView;

@property (nonatomic, strong) NSLayoutConstraint *constraintHeight;

@property (nonatomic, strong) UIColor *overlayBackgroundColor;

@end
