//
//  NumericalSettingAction.h
//  Pods
//
//  Created by Venkat Rao on 7/5/16.
//
//

#import "UserSettingsAction.h"

@interface NumericalSettingAction : UserSettingsAction

@property (nonatomic, strong) NSNumber *defaultValue;

@property (nonatomic, strong) NSNumber *maximumValue;
@property (nonatomic, strong) NSNumber *minimumValue;

-(NSNumber *) currentValue;

@end
