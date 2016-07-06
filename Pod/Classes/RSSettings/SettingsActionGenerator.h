//
//  SettingsActionGenerator.h
//  Preset
//
//  Created by Venkat Rao on 2/4/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@class SettingsAction;

@interface SettingsActionGenerator : NSObject

@property (strong, nonatomic) NSString *URLString;
@property (strong, nonatomic) NSString *shortDescription;
@property (strong, nonatomic) NSString *appId;
@property (weak, nonatomic) UIViewController *viewController;

-(SettingsAction *)mailAction;
-(SettingsAction *)textAction;
-(SettingsAction *)facebookShareAction;
-(SettingsAction *)twitterShareAction;

-(SettingsAction *)rateAppAction;


@end
