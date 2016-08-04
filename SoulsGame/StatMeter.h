//
//  StatMeter.h
//  SoulsGame
//
//  Created by Andrew Cummings on 7/7/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatMeter : UIView

@property (nonatomic) NSInteger maxTicks;
@property (nonatomic) NSInteger tickSpacing;
@property (nonatomic) UIColor* color;

@property (nonatomic) NSInteger amount;

@end
