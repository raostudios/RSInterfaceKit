//
//  FollowUsActionGenerator.h
//  Pods
//
//  Created by Venkat Rao on 6/27/16.
//
//

#import <Foundation/Foundation.h>
@class SettingsAction;
@class SocialAction;

@interface FollowUsActionGenerator : NSObject

@property (strong, nonatomic) NSString *twitter;
@property (strong, nonatomic) NSString *facebook;
@property (strong, nonatomic) NSString *instagram;
@property (strong, nonatomic) NSString *snapchat;
@property (strong, nonatomic) NSString *website;

-(SocialAction *)facebookLike;
-(SocialAction *)twitterFollow;
-(SocialAction *)instagramFollow;
-(SocialAction *)snapchatFollow;
-(SocialAction *)visitWebsite;

@end
