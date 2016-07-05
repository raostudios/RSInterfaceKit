//
//  NumericalSettingAction.m
//  Pods
//
//  Created by Venkat Rao on 7/5/16.
//
//

#import "NumericalSettingAction.h"

@implementation NumericalSettingAction

-(NSNumber *) currentValue {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:self.settingKey]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:self.settingKey];
    }
    return self.defaultValue;
}

@end
