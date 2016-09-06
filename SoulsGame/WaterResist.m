//
//  WaterResist.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/8/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "WaterResist.h"

@implementation WaterResist

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Water Resistance";
        self.type = ElementTypeWater;
        self.desc = @"Will resist negative water effects and buff positive ones";
        self.img = [UIImage imageNamed:@"watershield.jpg"];
        
        self.ID = @"002";
    }
    return self;
}

-(void)affectSpell:(Spell *)spell{
    if ([self willEffectSpell:spell]){
        if (spell.positiveEffect){
            spell.amount += self.amount;
        } else {
            spell.amount -= self.amount;
        }
    }
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Water Resistance grants %i less water damage taken, and %i more healing from water", (int)self.amount, (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    WaterResist* theCopy = [[WaterResist alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
