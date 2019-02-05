//
//  URLSettingsAction.m
//  Pods
//
//  Created by Venkat Rao on 3/26/17.
//
//

#import "URLSettingsAction.h"

@implementation URLSettingsAction

-(void (^)(void))action {
    return ^void(void) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlString] options:@{} completionHandler:nil];
    };
}

@end
