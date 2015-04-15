//
//  AlertView.h
//  The Big Clock
//
//  Created by Rao, Venkat on 1/1/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView

@property (nonatomic, weak) NSString *message;

-(void) showMessage:(NSString *) message withAnimation:(BOOL)animations forced:(BOOL) forced;
-(void) hideWithAnimation:(BOOL)animation;
@end
