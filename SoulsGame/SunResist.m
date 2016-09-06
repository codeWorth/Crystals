//
//  SunResist.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "SunResist.h"

@implementation SunResist

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Sun Resistance";
        self.type = ElementTypeSun;
        self.desc = @"Will resist negative Sun effects and buff positive ones";
        self.img = [UIImage imageNamed:@"lightshield.png"];
        
        self.ID = @"009";
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
    return [NSString stringWithFormat:@"Sun Resistance grants %i less water damage taken, and %i more buff from Sun", (int)self.amount, (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    SunResist* theCopy = [[SunResist alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
