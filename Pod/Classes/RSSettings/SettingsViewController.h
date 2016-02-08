//
//  SettingsViewController.h
//  Preset
//
//  Created by Venkat Rao on 2/3/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsActionGroup;

@interface SettingsViewController : UIViewController

@property (strong, nonatomic) UIImage *imageLogo;
@property (strong, nonatomic) NSString *appDescription;
@property (strong, nonatomic) UIImage *appLogo;

@property (strong, nonatomic) NSArray<SettingsActionGroup *> *actionGroups;

@end
