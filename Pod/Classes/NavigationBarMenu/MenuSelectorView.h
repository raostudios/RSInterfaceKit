//
//  AlbumSelectorView.h
//  Preset
//
//  Created by Venkat Rao on 4/6/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuSelectorView : UIView<UIAppearanceContainer>

@property (nonatomic, strong) UITableView * _Nonnull tableView;
@property (nonatomic, strong) UIView * _Nonnull overlayView;
@property (nonatomic, strong) NSLayoutConstraint * _Nonnull constraintHeight;
@property (nonatomic, strong) UIColor * _Nullable overlayBackgroundColor;

@end
