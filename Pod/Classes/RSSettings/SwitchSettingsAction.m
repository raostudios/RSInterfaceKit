//
//  SwitchSettingsAction.m
//  Pods
//
//  Created by Venkat Rao on 7/5/16.
//
//

#import "SwitchSettingsAction.h"

@implementation SwitchSettingsAction

-(BOOL)currentValue {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:self.settingKey]) {
        return [[NSUserDefaults standardUserDefaults] boolForKey:self.settingKey];
    }
    
    return self.defaultValue;
}

@end
