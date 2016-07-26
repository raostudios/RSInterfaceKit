//
//  LogoAction.m
//  Pods
//
//  Created by Venkat Rao on 6/28/16.
//
//

#import "LogoAction.h"

@implementation LogoAction

-(void (^)(void))action {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.raostudios.com"]];
}

@end
