//
//  AppSettingAction.m
//  Pods
//
//  Created by Venkat Rao on 3/1/16.
//
//

#import "AppSettingAction.h"

@implementation AppSettingAction

-(void (^)(void))action {
    return ^void(void) {
        if ([self.appURL length] && [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:self.appURL]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appURL] options:@{} completionHandler:nil];
        } else {
            NSString *appStoreLink = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/apple-store/id%@?pt=1507981&mt=8", self.appId];
            if ([self.campaignId length]) {
                appStoreLink = [NSString stringWithFormat:@"%@&ct=%@", appStoreLink, self.campaignId];
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreLink] options:@{} completionHandler:nil];
        }
    };
}


@end
