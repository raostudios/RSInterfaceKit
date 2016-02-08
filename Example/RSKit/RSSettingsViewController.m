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
    
        self.actionGroups = @[shareGroup];
    }
    
    return self;
}

@end
