//
//  CollectionViewDataSource.m
//  CollectionViewTest
//
//  Created by Venkat Rao on 9/28/15.
//  Copyright © 2015 Rao Studios. All rights reserved.
//

#import "CollectionViewDataSource.h"
#import "ImageManager.h"
#import "UserLibraryCollectionViewCell.h"

@import Photos;

@interface CollectionViewDataSource () <PHPhotoLibraryChangeObserver>

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation CollectionViewDataSource

static NSString *const LibraryCellIdentifier = @"LibraryItemIdentifier";

-(instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    self = [super init];
    if (self) {
        [collectionView registerClass:[UserLibraryCollectionViewCell class]
                forCellWithReuseIdentifier:LibraryCellIdentifier];
        collectionView.dataSource = self;
        
        self.collectionView = collectionView;
        
        [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
    }
    return self;
}

-(void)dealloc {
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

-(void)setCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[UserLibraryCollectionViewCell class]
       forCellWithReuseIdentifier:LibraryCellIdentifier];
    collectionView.dataSource = self;
    
    _collectionView = collectionView;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[ImageManager sharedManager] numberOfImages];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UserLibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LibraryCellIdentifier forIndexPath:indexPath];
    
    [[ImageManager sharedManager] imageAtIndex:indexPath.item withCompletionBlock:^(UIImage * image) {
        UserLibraryCollectionViewCell *currentCell = (UserLibraryCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if (currentCell) {
            currentCell.imageViewThumbnail.image = image;
        }
    }];
    
    return cell;
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ImageManager sharedManager] updateResults];
        [self.collectionView reloadData];
    });
}

@end
