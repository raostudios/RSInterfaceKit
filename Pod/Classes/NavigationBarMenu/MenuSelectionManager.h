//
//  MenuSelectionManager.h
//  Preset
//
//  Created by Venkat Rao on 5/26/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

@import UIKit;

@class MenuSelectionManager;

#import "MenuSelectionViewController.h"

@interface MenuSelectionManager : NSObject<UIAppearanceContainer>

@property (nonatomic, strong) UIButton * _Nonnull buttonMenuSelector;
@property (nonatomic, weak) id<MenuSelectionDelegate> _Nullable delegate;
@property (nonatomic, weak) id<MenuSelectionDataSource> _Nullable dataSource;
@property (nonatomic, weak) UIViewController * _Nullable parentViewController;

@end
