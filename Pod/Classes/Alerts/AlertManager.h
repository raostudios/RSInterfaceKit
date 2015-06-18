//
//  AlertManger.h
//  TheBigClock
//
//  Created by Rao, Venkat on 3/4/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertManager : NSObject

+(instancetype) sharedManager;

-(void) showAlert:(NSString *) message withAnimation:(BOOL)animated forced:(BOOL) forced;
-(void) showUniqueAlert:(NSString *) message withAnimation:(BOOL)animation withIdentifier:(NSString *)identifier;

-(void) showNextQueuedAlert;

@end
