//
//  ToolTip.h
//  ToolTip
//
//  Created by Venkat Rao on 2/13/16.
//  Copyright © 2016 Rao Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PopUpDirection) {
    PopUpDirectionUp,
    PopUpDirectionLeft,
    PopUpDirectionRight,
    PopUpDirectionDown,
    PopUpDirectionAuto
};

@interface PopUpView : UIView

-(instancetype) initWithContainer:(UIView *)container;

@property (nonatomic, assign) PopUpDirection direction;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, assign) CGFloat cornerRadius;


@end
