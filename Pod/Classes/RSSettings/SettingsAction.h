//
//  SettingsAction.h
//  Preset
//
//  Created by Venkat Rao on 2/4/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsAction : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *subtitle;

@property (assign, nonatomic) BOOL pushIndicator;
@property (copy, nonatomic) void (^action)(void);

@end
