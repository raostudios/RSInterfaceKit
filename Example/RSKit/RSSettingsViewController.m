//
//  PresetSettingsViewController.m
//  Preset
//
//  Created by Venkat Rao on 2/4/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import "RSSettingsViewController.h"

#import "SettingsActionGenerator.h"
#import "SettingsAction.h"
#import "AppSettingAction.h"
#import "SettingsActionGroup.h"

@implementation RSSettingsViewController

-(instancetype)init {
    self = [super init];
    
    if (self) {
        
        [SettingsActionGenerator sharedGenerator].appId = @"990229325";
        [SettingsActionGenerator sharedGenerator].shortDescription = @"Create your own Filters with Preset!";
        [SettingsActionGenerator sharedGenerator].URLString = @"http://apple.co/1PTwa6E";
        [SettingsActionGenerator sharedGenerator].viewController = self;
        
        self.imageLogo = [UIImage imageNamed:@"logo"];
        self.appLogo = [UIImage imageNamed:@"icon"];
        self.appDescription = @"This is an example app that shows all the components in RSInterfaceKit";
        
        SettingsActionGroup *shareGroup = [SettingsActionGroup new];
        shareGroup.name = @"Tell Others About Preset";
        shareGroup.actions = @[[[SettingsActionGenerator sharedGenerator] mailAction], [[SettingsActionGenerator sharedGenerator] textAction]];
    
        
        
        AppSettingAction *bigClockSettingAction = [AppSettingAction new];
        bigClockSettingAction.appId = @"583451358";
        bigClockSettingAction.name = @"The Big Clock";
        bigClockSettingAction.appURL = @"thebigclock://";
        bigClockSettingAction.imageName = @"thebigclockicon";
        bigClockSettingAction.campaignId = @"rskit_example_app";
        
        SettingsActionGroup *appGroup = [SettingsActionGroup new];
        appGroup.name = @"Our other Apps";
        appGroup.actions = @[bigClockSettingAction];
        
        self.actionGroups = @[shareGroup, appGroup];

        
    }
    
    return self;
}

@end
