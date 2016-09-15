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

-(NSString * _Nonnull)titleForIndexPath:(NSIndexPath * _Nonnull)indexPath;
-(NSUInteger)numberOfCellsInMenuSelectionManager:(MenuSelectionViewController * _Nonnull)manager;
-(UITableViewCell * _Nonnull)cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath forManager:(MenuSelectionViewController * _Nonnull)manager;

@end

@protocol MenuSelectionDelegate <NSObject>

-(void)menuSelectionManager:(MenuSelectionViewController * _Nonnull)manager cellSelectedAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

@end


@interface MenuSelectionViewController : UIViewController

@property (nonatomic, strong, readonly) NSLayoutConstraint * _Nonnull constraintHeight;
@property (nonatomic, weak) id<MenuSelectionDelegate> _Nullable delegate;
@property (nonatomic, weak) id<MenuSelectionDataSource> _Nullable dataSource;
@property (nonatomic, strong,readonly) UIView * _Nonnull overlayView;

@end
