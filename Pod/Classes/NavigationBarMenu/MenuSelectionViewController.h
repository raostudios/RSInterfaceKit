//
//  AlbumSelectorViewController.h
//  Preset
//
//  Created by Venkat Rao on 4/6/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAssetCollection;
@class MenuSelectionViewController;

@protocol MenuSelectionDataSource <NSObject>

-(NSString *)titleForIndexPath:(NSIndexPath *)indexPath;
-(NSUInteger)numberOfCellsInMenuSelectionManager:(MenuSelectionViewController *)manager;
-(UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath forManager:(MenuSelectionViewController *)manager;

@end

@protocol MenuSelectionDelegate <NSObject>

-(void)menuSelectionManager:(MenuSelectionViewController *)manager cellSelectedAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface MenuSelectionViewController : UIViewController

@property (nonatomic, strong, readonly) NSLayoutConstraint *constraintHeight;
@property (nonatomic, weak) id<MenuSelectionDelegate>delegate;
@property (nonatomic, weak) id<MenuSelectionDataSource>dataSource;
@property (nonatomic, strong,readonly) UIView *overlayView;

@end
