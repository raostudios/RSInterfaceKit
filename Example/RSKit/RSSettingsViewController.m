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
#import "SwitchSettingsAction.h"
#import "NumericalSettingAction.h"

@implementation RSSettingsViewController

-(instancetype)init {
    self = [super init];
    
    if (self) {
        
        SettingsActionGenerator *generator = [SettingsActionGenerator new];
        generator.appId = @"990229325";
        generator.shortDescription = @"Create your own Filters with Preset!";
        generator.URLString = @"http://apple.co/1PTwa6E";
        generator.viewController = self;
        
        self.imageLogo = [UIImage imageNamed:@"logo"];
        self.appLogo = [UIImage imageNamed:@"icon"];
        self.appDescription = @"This is an example app that shows all the components in RSInterfaceKit";
        
        SettingsActionGroup *shareGroup = [SettingsActionGroup new];
        shareGroup.name = @"Tell Others About Preset";
        shareGroup.actions = @[[generator mailAction], [generator textAction]];
    
        
        AppSettingAction *bigClockSettingAction = [AppSettingAction new];
        bigClockSettingAction.appId = @"583451358";
        bigClockSettingAction.name = @"The Big Clock";
        bigClockSettingAction.appURL = @"thebigclock://";
        bigClockSettingAction.imageName = @"thebigclockicon";
        bigClockSettingAction.campaignId = @"rskit_example_app";
        
        SettingsActionGroup *appGroup = [SettingsActionGroup new];
        appGroup.name = @"Our other Apps";
        appGroup.actions = @[bigClockSettingAction];
        

        SwitchSettingsAction *switchAction = [SwitchSettingsAction new];
        switchAction.name = @"Turn on Light";
        switchAction.defaultValue = YES;
        switchAction.changeNotificationName = @"LightOnChanged";
        switchAction.settingKey = @"LightOnKey";
        
        NumericalSettingAction *numericalAction = [NumericalSettingAction new];
        numericalAction.name = @"Brightness";
        numericalAction.defaultValue = @(.25);
        numericalAction.maximumValue = @(1.0);
        numericalAction.minimumValue = @(-1.0);
        numericalAction.changeNotificationName = @"BrightnessChanged";
        numericalAction.settingKey = @"BrightnessSettingKey";
        
        SettingsAction *subtitleAction = [SettingsAction new];
        subtitleAction.pushIndicator = YES;
        subtitleAction.name = @"Title";
        subtitleAction.subtitle = @"Subtitle";

        
        SettingsActionGroup *settingsGroup = [SettingsActionGroup new];
        settingsGroup.name = @"General Settings";
        settingsGroup.actions = @[switchAction, numericalAction, subtitleAction];
        
        self.actionGroups = @[settingsGroup, shareGroup, appGroup];
        
    }
    
    return self;
}

@end
