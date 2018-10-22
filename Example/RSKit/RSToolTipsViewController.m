//
//  RSToolTipsViewController.m
//  RSInterfaceKit
//
//  Created by Venkat Rao on 5/25/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import "RSToolTipsViewController.h"
#import "PopUpPresenter.h"

@interface RSToolTipsViewController ()
@property (nonatomic, strong) UIBarButtonItem *barButton;
@end

@implementation RSToolTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *showToolTip = [UIButton buttonWithType:UIButtonTypeCustom];
    [showToolTip setTitle:@"Show Tool Tip" forState:UIControlStateNormal];
    showToolTip.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:showToolTip];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:showToolTip attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:showToolTip attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [showToolTip addTarget:self action:@selector(showTooltip:) forControlEvents:UIControlEventTouchUpInside];
    
    self.barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(toolbarItemSelected:)];
    [self.navigationController setToolbarHidden:NO];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    self.toolbarItems = @[flexSpace, self.barButton, flexSpace];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textColor = [UIColor greenColor];
    label.backgroundColor = [UIColor blueColor];
    label.text = @"Select a Reference Image";
    
    [[PopUpPresenter sharedPresentor] popupContainer:label
                                   fromBarButtonItem:self.barButton
                                           direction:PopUpDirectionAuto];
}

-(void)toolbarItemSelected:(id)sender {
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    mediaUI.allowsEditing = NO;
    mediaUI.modalPresentationStyle = UIModalPresentationPopover;
    mediaUI.popoverPresentationController.barButtonItem = sender;

    [self presentViewController:mediaUI animated:YES completion:nil];
}

-(void)showTooltip:(UIButton *)sender {
    
    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textColor = [UIColor greenColor];
    label.backgroundColor = [UIColor blueColor];
    label.text = @"This is a tooltip";
    
    [[PopUpPresenter sharedPresentor] popupContainer:label fromView:sender direction:PopUpDirectionAuto];
}

@end
