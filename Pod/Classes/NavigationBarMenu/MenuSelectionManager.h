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

@property (nonatomic, strong) UIButton *buttonMenuSelector;
@property (nonatomic, weak) id<MenuSelectionDelegate>delegate;
@property (nonatomic, weak) id<MenuSelectionDataSource>dataSource;
@property (nonatomic, weak) UIViewController *parentViewController;

@end
