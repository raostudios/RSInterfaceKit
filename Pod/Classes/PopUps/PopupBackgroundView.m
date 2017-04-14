//
//  PopupBackgroundView.m
//  Pods
//
//  Created by Venkat Rao on 4/14/17.
//
//

#import "PopupBackgroundView.h"

@implementation PopupBackgroundView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    [self.delegate dismissPopUpForBackgroundView:self];
    return nil;
}

@end
