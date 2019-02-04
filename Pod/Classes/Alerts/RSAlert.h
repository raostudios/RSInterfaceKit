//
//  Alert.h
//  Pods
//
//  Created by Venkat Rao on 1/16/16.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RSAlertType) {
    RSAlertTypeBanner,
    RSAlertTypeModal
};

@interface RSAlert : NSObject

@property (strong, nonatomic) NSString *uniqueId;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) void (^actionOnTap)(void);
@property (strong, nonatomic) void (^dismiss)(void);
@property (strong, nonatomic) BOOL (^shouldDisplay)(void);
@property (assign, nonatomic) BOOL retry;
@property (assign, nonatomic) RSAlertType alertType;
@property (assign, nonatomic) NSTimeInterval seconds;

@end

