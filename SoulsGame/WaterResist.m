//
//  WaterResist.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/8/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "WaterResist.h"

@implementation WaterResist

@synthesize name;
@synthesize resistAmount;
@synthesize img;
@synthesize type;
@synthesize desc;
@synthesize minorBuffApplied;
@synthesize majorBuffApplied;

-(instancetype)init{
    if (self = [super init]){
        self.minorBuffApplied = NO;
        self.majorBuffApplied = NO;
        
        self.resistAmount = 1;
        self.name = @"Water Resistance";
        self.type = Water;
        self.desc = @"Will resist negative water effects and buff positive ones";
        self.img = [UIImage imageNamed:@"watershield.jpg"];
    }
    return self;
}

-(void)applyMinorBuff{
    self.resistAmount += MINOR_BUFF_AMOUNT;
    self.minorBuffApplied = YES;
}

-(void)applyMajorBuff{
    self.resistAmount += MAJOR_BUFF_AMOUNT;
    self.majorBuffApplied = YES;
}

-(void)resistSpell:(NSObject<Spell>*)spell{
    if (spell.type == Water){
        if (spell.positiveEffect){
            spell.amount += self.resistAmount;
        } else {
            spell.amount -= self.resistAmount;
        }
    }
}

-(NSInteger)cost{
    return RESIST_COST;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Water Resistance grants %i less water damage taken, and %i more healing from water", (int)self.resistAmount, (int)self.resistAmount];
}

@end
