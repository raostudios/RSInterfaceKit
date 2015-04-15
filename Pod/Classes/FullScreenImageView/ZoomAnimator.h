//
//  ZoomAnimator.h
//  Chrytotype
//
//  Created by Rao, Venkat on 11/19/14.
//  Copyright (c) 2014 Venkat Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class FullImageViewController;
@interface ZoomAnimator : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) FullImageViewController *fullImageViewController;

@end
