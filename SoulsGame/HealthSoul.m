//
//  HealthSoul.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "HealthSoul.h"

@implementation HealthSoul

-(instancetype)initWithHealth:(NSInteger)health{
    if (self = [super init]){
        self.amount = health;
        self.name = @"Health";
        self.desc = @"Amount of health that this crystal has.";
    }
    return self;
}

@end
