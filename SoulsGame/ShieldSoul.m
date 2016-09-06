//
//  ShieldSoul.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "ShieldSoul.h"

@implementation ShieldSoul

@synthesize name;
@synthesize img;
@synthesize amount;
@synthesize desc;
@synthesize minorBuffApplied;
@synthesize majorBuffApplied;
@synthesize ID;

-(instancetype)initWithShield:(NSInteger)shield{
    if (self = [super init]){
        self.amount = shield;
        self.name = @"Shield";
        self.desc = @"Amount of shielding that this crystal has.";
    }
    return self;
}

@end
