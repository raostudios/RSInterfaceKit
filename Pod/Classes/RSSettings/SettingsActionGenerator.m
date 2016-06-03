//
//  SettingsActionGenerator.m
//  Preset
//
//  Created by Venkat Rao on 2/4/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import "SettingsActionGenerator.h"
#import "SettingsAction.h"

@import MessageUI;
@import Social;
@import UIKit;

@interface SettingsActionGenerator ()<MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@end

@implementation SettingsActionGenerator

+(instancetype)sharedGenerator {
    static SettingsActionGenerator *sharedGenerator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGenerator = [SettingsActionGenerator new];
    });
    return sharedGenerator;
}

-(SettingsAction *)mailAction {
    SettingsAction *action = [SettingsAction new];
    action.name = @"Mail";
    action.action = ^{
        [self shareMail:nil];
    };
    return action;
}

-(SettingsAction *)textAction {
    SettingsAction *action = [SettingsAction new];
    action.name = @"Text";
    action.action = ^{
        [self shareTextMessage:nil];
    };
    return action;
}

-(SettingsAction *)facebookShareAction {
    SettingsAction *action = [SettingsAction new];
    action.name = @"Facebook";
    action.action = ^{
        [self shareFacebookPressed:nil];
    };
    return action;
}
-(SettingsAction *)twitterShareAction {
    SettingsAction *action = [SettingsAction new];
    action.name = @"Twitter";
    action.action = ^{
        [self shareTwitterPressed:nil];
    };
    return action;
}

-(SettingsAction *)rateAppAction {
    
    SettingsAction *action = [SettingsAction new];
    action.name = @"Rate App";
    action.action = ^{
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software", self.appId];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    };
    return action;
}

- (IBAction)shareTwitterPressed:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheetOBJ = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheetOBJ setInitialText:[self descriptionWithURLString]];
        tweetSheetOBJ.completionHandler = ^(SLComposeViewControllerResult result) {
            switch (result) {
                case SLComposeViewControllerResultCancelled:
//                    [Flurry logEvent:@"Twitter Share" withParameters:@{@"Result" :@"Cancelled"}];
                    break;
                case SLComposeViewControllerResultDone:
//                    [Flurry logEvent:@"Twitter Share" withParameters:@{@"Result" :@"Success"}];
                    break;
                default:
                    break;
            }
        };
        [self.viewController presentViewController:tweetSheetOBJ animated:YES completion:nil];
    }else {
        [self showServiceUnavailableMessage:@"Twitter"];
    }
}
- (IBAction)shareFacebookPressed:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *facebookSheetOBJ = [SLComposeViewController
                                                     composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookSheetOBJ setInitialText:[self descriptionWithURLString]];
        facebookSheetOBJ.completionHandler = ^(SLComposeViewControllerResult result) {
            switch (result) {
                case SLComposeViewControllerResultCancelled:
//                    [Flurry logEvent:@"Facebook Share" withParameters:@{@"Result" :@"Cancelled"}];
                    break;
                case SLComposeViewControllerResultDone:
//                    [Flurry logEvent:@"Facebook Share" withParameters:@{@"Result" :@"Success"}];
                    break;
                default:
                    break;
            }
        };
        [self.viewController presentViewController:facebookSheetOBJ animated:YES completion:nil];
    }else {
        [self showServiceUnavailableMessage:@"Facebook"];
    }
}


-(void) showServiceUnavailableMessage:(NSString *) service {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Service Unavailable"
                                                     message:[NSString stringWithFormat:@"%@ is unavailable on your device.", service]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];
}

- (void)shareMail:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController * mailVC = [[MFMailComposeViewController alloc] init];
        mailVC.navigationBar.tintColor = [[UINavigationBar appearance] tintColor];
        [mailVC setSubject:self.shortDescription];
        [mailVC setMessageBody:self.URLString isHTML:NO];
        [mailVC setMailComposeDelegate:self];
        [self.viewController presentViewController:mailVC animated:YES completion:nil];
    }else {
        [self showServiceUnavailableMessage:@"Messaging"];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller
           didFinishWithResult:(MFMailComposeResult)result
                         error:(NSError *)error
{
    //    switch (result) {
    //        case MFMailComposeResultFailed:
    //            [Flurry logEvent:@"Mail Share" withParameters:@{@"Result" :@"Failed"}];
    //        case MFMailComposeResultCancelled:
    //            [Flurry logEvent:@"Mail Share" withParameters:@{@"Result" :@"Cancelled"}];
    //            break;
    //        case MFMailComposeResultSaved:
    //            [Flurry logEvent:@"Mail Share" withParameters:@{@"Result" :@"Saved"}];
    //            break;
    //        case MFMailComposeResultSent:
    //            [Flurry logEvent:@"Mail Share" withParameters:@{@"Result" :@"Sent"}];
    //            break;
    //        default:
    //            break;
    //    }
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)shareTextMessage:(id)sender {
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController * textVC = [[MFMessageComposeViewController alloc] init];
        textVC.navigationBar.tintColor = [[UINavigationBar appearance] tintColor];
        [textVC setBody:[self descriptionWithURLString]];
        [textVC setMessageComposeDelegate:self];
        [self.viewController presentViewController:textVC animated:YES completion:nil];
    }else {
        [self showServiceUnavailableMessage:@"Text Messaging"];
    }
}

-(NSString *)descriptionWithURLString {
    return [NSString stringWithFormat:@"%@ %@", self.shortDescription, self.URLString];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    //    switch (result) {
    //        case MessageComposeResultCancelled:
    //            [Flurry logEvent:@"Text Share" withParameters:@{@"Result" :@"Cancelled"}];
    //            break;
    //        case MessageComposeResultSent:
    //            [Flurry logEvent:@"Text Share" withParameters:@{@"Result" :@"Sent"}];
    //            break;
    //        case MessageComposeResultFailed:
    //            [Flurry logEvent:@"Text Share" withParameters:@{@"Result" :@"Failed"}];
    //            break;
    //        default:
    //            break;
    //    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
