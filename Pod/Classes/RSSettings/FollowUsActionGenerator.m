//
//  FollowUsActionGenerator.m
//  Pods
//
//  Created by Venkat Rao on 6/27/16.
//
//

#import "FollowUsActionGenerator.h"
#import "SettingsAction.h"
#import "SocialAction.h"

@import Foundation;

@implementation FollowUsActionGenerator

-(SocialAction *)facebookLike {
    SocialAction *action = [SocialAction new];
    action.name = @"Like Us on Facebook";
    action.glyphName = @"facebook";
    action.action = ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"https://facebook.com/%@", self.facebook]]];
    };
    return action;
}

-(SocialAction *)instagramFollow {
    SocialAction *action = [SocialAction new];
    action.name = [NSString stringWithFormat:@"Follow @%@ on Instagram", self.instagram];
    action.glyphName = @"instagram";
    action.action = ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"https://instagram.com/%@", self.instagram]]];
    };
    return action;
}

-(SocialAction *)twitterFollow {
    SocialAction *action = [SocialAction new];
    action.name = [NSString stringWithFormat:@"Follow @%@ on Twitter", self.twitter];
    action.glyphName = @"twitter";
    action.action = ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"https://twitter.com/%@", self.twitter]]];
    };
    return action;
}

-(SocialAction *)snapchatFollow {
    SocialAction *action = [SocialAction new];
    action.name = @"Follow Us on Snapchat";
    action.glyphName = @"snapchat";
    action.action = ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://www.snapchat.com/add/%@", self.snapchat]]];
    };
    return action;
}

-(SocialAction *)visitWebsite {
    SocialAction *action = [SocialAction new];
    action.name = @"Visit our Website";
    action.glyphName = @"website";
    action.action = ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.website]];
    };
    return action;
}

@end
