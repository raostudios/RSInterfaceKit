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

-(void) showAlert:(NSString *) message withAnimation:(BOOL)animations forced:(BOOL) forced;

@end
