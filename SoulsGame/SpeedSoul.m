//
//  SpeedSoul.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "SpeedSoul.h"

@implementation SpeedSoul

-(instancetype)initWithSpeed:(NSInteger)speed{
    if (self = [super init]){
        self.amount = speed;
        self.name = @"Speed";
        self.desc = @"How quickly this crystal can attack.";
    }
    return self;
}

@end
