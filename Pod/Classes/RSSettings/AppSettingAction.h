//
//  AppSettingAction.h
//  Pods
//
//  Created by Venkat Rao on 3/1/16.
//
//

#import "SettingsAction.h"

@interface AppSettingAction : SettingsAction

@property (strong, nonatomic) NSString *appURL;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *campaignId;

@end
