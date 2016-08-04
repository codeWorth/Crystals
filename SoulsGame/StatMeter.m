//
//  StatMeter.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/7/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "StatMeter.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation StatMeter

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    NSInteger tickWidth = (rect.size.width - (self.maxTicks)*self.tickSpacing)/self.maxTicks;
    NSInteger tickHeight = rect.size.height - self.tickSpacing*2;
    
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    
    for (NSInteger i = 0; i < self.amount; i++) {
        NSInteger startX = i * (self.tickSpacing + tickWidth) + self.tickSpacing;
        
        CGRect tick = CGRectMake(startX, self.tickSpacing, tickWidth, tickHeight);
        CGContextFillRect(ctx, tick);
    }
}

@end
