//
//  SwitchSettingsAction.h
//  Pods
//
//  Created by Venkat Rao on 7/5/16.
//
//

#import "UserSettingsAction.h"

@interface SwitchSettingsAction : UserSettingsAction

@property (nonatomic, assign) BOOL defaultValue;

-(BOOL) currentValue;

@end
