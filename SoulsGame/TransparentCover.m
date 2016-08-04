//
//  TransparentCover.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/1/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "TransparentCover.h"

@implementation TransparentCover

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    
    // If the hitView is THIS view, return the view that you want to receive the touch instead:
    if (hitView == self) {
        return nil;
    }
    // Else return the hitView (as it could be one of this view's buttons):
    return hitView;
}

@end
