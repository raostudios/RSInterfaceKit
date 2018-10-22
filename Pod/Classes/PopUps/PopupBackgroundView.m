//
//  PopupBackgroundView.m
//  Pods
//
//  Created by Venkat Rao on 4/14/17.
//
//

#import "PopupBackgroundView.h"

@implementation PopupBackgroundView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        [self addGestureRecognizer:recognizer];
    }
    
    return self;
}

-(void)viewTapped:(UITapGestureRecognizer *)sender {
    [self.delegate dismissPopUpForBackgroundView:self];
}

@end
