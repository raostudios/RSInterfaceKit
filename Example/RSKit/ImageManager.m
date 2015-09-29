//
//  ImageManager.m
//  CollectionViewTest
//
//  Created by Venkat Rao on 8/9/15.
//  Copyright (c) 2015 Rao Studios. All rights reserved.
//

#import "ImageManager.h"

@import Photos;


@interface ImageManager()

@property (strong, nonatomic) PHFetchResult *results;

@end

@implementation ImageManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static ImageManager * sharedManager;
    dispatch_once(&onceToken, ^{
        sharedManager = [ImageManager new];
    });
    
    return sharedManager;
}

-(NSUInteger) numberOfImages {
    return self.results.count;
}

-(void)imageAtIndex:(NSUInteger) index withCompletionBlock:(void(^)(UIImage *))completionBlock {
    
    PHImageManager *manager = [PHImageManager defaultManager];
    
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    options.networkAccessAllowed = YES;
    
    [manager requestImageForAsset:[self.results objectAtIndex:index]
                       targetSize:CGSizeMake(1000, 1000)
                      contentMode:PHImageContentModeAspectFit
                          options:options
                    resultHandler:^(UIImage *result, NSDictionary *info) {
        if (completionBlock) {
            completionBlock(result);
        }
    }];
}

-(void) updateResults {
    _results = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
}

-(PHFetchResult *)results {
    if (!_results) {
        _results = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    }
    
    return _results;
}

@end
