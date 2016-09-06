//
//  ShadowResist.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "ShadowResist.h"

@implementation ShadowResist

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Shadow Resistance";
        self.type = ElementTypeShadow;
        self.desc = @"Will resist negative shadow effects and buff positive ones";
        self.img = [UIImage imageNamed:@"shadow.jpg"];
        
        self.ID = @"011";
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
    return [NSString stringWithFormat:@"Shadow Resistance grants %i less water damage taken, and %i more buff from Shadow", (int)self.amount, (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    ShadowResist* theCopy = [[ShadowResist alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
