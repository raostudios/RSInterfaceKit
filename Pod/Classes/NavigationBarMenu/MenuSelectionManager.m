//
//  MenuSelectionManager.m
//  Preset
//
//  Created by Venkat Rao on 5/26/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import "MenuSelectionManager.h"
#import "MenuSelectionViewController.h"

@interface MenuSelectionManager () <MenuSelectionDelegate>

@property (nonatomic, strong) MenuSelectionViewController *menuSelectionViewController;

-(void)showMenu;
-(void)hideMenu;

@end

@implementation MenuSelectionManager

-(instancetype)init {
    self = [super init];
    
    if (self) {
        [self.buttonMenuSelector addTarget:self
                             action:@selector(albumSelected:)
                   forControlEvents:UIControlEventTouchUpInside];
        
            UITapGestureRecognizer *tapRecognized = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(hideMenu)];
            [self.menuSelectionViewController.overlayView addGestureRecognizer:tapRecognized];
    }
    return self;
}

-(UIButton *)buttonMenuSelector {
    if (!_buttonMenuSelector) {
        
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *bundleURL = [bundle URLForResource:@"RSInterfaceKit_NavigationBarMenu" withExtension:@"bundle"];
        
        _buttonMenuSelector = [UIButton buttonWithType:UIButtonTypeSystem];
        _buttonMenuSelector.frame = CGRectMake(0, 0, 200, 44);
        [_buttonMenuSelector setTintColor:[UIColor whiteColor]];
                
        [_buttonMenuSelector setImage:[[UIImage imageNamed:@"chevron-down"inBundle:[NSBundle bundleWithURL:bundleURL]  compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                      forState:UIControlStateNormal];
    }
    return _buttonMenuSelector;
}cd

-(void)albumSelected:(UIButton *)sender {
    
    if (self.menuSelectionViewController.parentViewController) {
        [self hideMenu];
        return;
    }
    
    [self.parentViewController addChildViewController:self.menuSelectionViewController];
    [self.parentViewController.view addSubview:self.menuSelectionViewController.view];
    [self.menuSelectionViewController didMoveToParentViewController:self.parentViewController];
    self.menuSelectionViewController.view.frame = self.parentViewController.view.frame;
    
    [self showMenu];
}

-(void)hideMenu {
    
    self.menuSelectionViewController.constraintHeight.constant = 0.0;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut animations:^{
                            [self.menuSelectionViewController.view layoutIfNeeded];
                        } completion:^(BOOL finished) {
                            [self.menuSelectionViewController willMoveToParentViewController:nil];
                            [self.menuSelectionViewController.view removeFromSuperview];
                            [self.menuSelectionViewController removeFromParentViewController];
                        }];
}

-(void)showMenu {
    
    self.menuSelectionViewController.constraintHeight.constant = 0.0;
    [self.menuSelectionViewController.view layoutIfNeeded];
    self.menuSelectionViewController.constraintHeight.constant = CGRectGetMidY(self.parentViewController.view.frame);
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseIn animations:^{
        [self.menuSelectionViewController.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)menuSelectionManager:(MenuSelectionViewController *)manager cellSelectedAtIndexPath:(NSIndexPath *)indexPath {
    [self hideMenu];
    [self updateTitleForIndexPath:indexPath];
    [self.delegate menuSelectionManager:manager cellSelectedAtIndexPath:indexPath];
}

-(void)setDataSource:(id<MenuSelectionDataSource>)dataSource {
    self.menuSelectionViewController.dataSource = dataSource;
    [self updateTitleForIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}

-(void)updateTitleForIndexPath:(NSIndexPath *)indexPath {
    [self.buttonMenuSelector setTitle:[self.dataSource titleForIndexPath:indexPath] forState:UIControlStateNormal];
}

-(id<MenuSelectionDataSource>)dataSource {
    return self.menuSelectionViewController.dataSource;
}

-(void)setSelectionButtonColor:(UIColor *)selectionButtonColor {
    [self.buttonMenuSelector setTitleColor:selectionButtonColor forState:UIControlStateNormal];
}

-(void)setSelectionButtonFont:(UIFont *)selectionButtonFont {
    self.buttonMenuSelector.titleLabel.font = selectionButtonFont;
}

-(MenuSelectionViewController *)menuSelectionViewController {
    if (!_menuSelectionViewController) {
        _menuSelectionViewController = [[MenuSelectionViewController alloc] init];
        _menuSelectionViewController.delegate = self;
    }
    return _menuSelectionViewController;
}

@end
