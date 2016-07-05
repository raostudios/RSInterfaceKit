//
//  UserSettingsAction.h
//  Pods
//
//  Created by Venkat Rao on 7/5/16.
//
//

#import "SettingsAction.h"

@interface UserSettingsAction : SettingsAction

@property (nonatomic, strong) NSString *settingKey;
@property (nonatomic, strong) NSString *changeNotificationName;

@end
