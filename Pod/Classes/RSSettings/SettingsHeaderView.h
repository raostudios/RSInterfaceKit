//
//  SettingsHeaderView.h
//  Pods
//
//  Created by Venkat Rao on 2/7/16.
//
//

#import <UIKit/UIKit.h>

@interface SettingsHeaderView : UIView

@property (nonatomic, strong) UIImage *imageLogo;
@property (nonatomic, strong) NSString *text;

-(CGRect) frameForHeaderForMaxWidth:(CGFloat)maxWidth;

@end
