//
//  ImageManager.h
//  CollectionViewTest
//
//  Created by Venkat Rao on 8/9/15.
//  Copyright (c) 2015 Rao Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ImageManager : NSObject

+(instancetype) sharedManager;

-(NSUInteger) numberOfImages;
-(void)imageAtIndex:(NSUInteger) index withCompletionBlock:(void(^)(UIImage *))completionBlock;
-(void)updateResults;

@end
