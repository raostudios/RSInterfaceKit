//
//  SettingsActionGroup.h
//  Preset
//
//  Created by Venkat Rao on 2/4/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SettingsAction;

@interface SettingsActionGroup : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray<SettingsAction *> *actions;

@end