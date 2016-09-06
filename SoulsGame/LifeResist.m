//
//  LifeResist.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "LifeResist.h"

@implementation LifeResist

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Life Resistance";
        self.type = ElementTypeLife;
        self.desc = @"Will resist negative Life effects and buff positive ones";
        self.img = [UIImage imageNamed:@"plantshield.jpg"];
        
        self.ID = @"008";
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
    return [NSString stringWithFormat:@"Life Resistance grants %i less Life damage taken, and %i more healing from Life", (int)self.amount, (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    LifeResist* theCopy = [[LifeResist alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
