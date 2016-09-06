//
//  Submerge.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Submerge.h"
#import "NextSpellSoul.h"
#import "SpellDebuff.h"
#import "Game.h"

@implementation Submerge

-(NSMutableArray*)affectCrystal:(Crystal *)crystal{
    NextSpellSoul* soul = [[NextSpellSoul alloc]initWithSoul:[[SpellDebuff alloc]init]];
    [soul getSoul].amount = self.amount;
    return [NSMutableArray arrayWithObject:soul];
}

-(instancetype)init{
    if (self = [super init]){
        self.type = ElementTypeMoon;
        self.positiveEffect = NO;
        self.name = @"Submerge";
        self.cost = 1;
        self.desc = @"A small debuff that will reduce the power of the target's next spell by 3";
        self.amount = 3;
        self.flavorText = @"Don't worry, crystals don't have to breath air... we think.";
        self.img = [UIImage imageNamed:@"drowning.jpg"];
        
        self.canTargetEnemies = YES;
        self.canTargetFriendlies = NO;
        
        self.ID = @"007";
    }
    return self;
}

-(instancetype)copyWithZone:(NSZone *)zone{
    Submerge* theCopy = [[Submerge alloc]init];
    theCopy.amount = self.amount;
    
    return theCopy;
}

-(NSArray*)targetsForCrystal:(Crystal *)crystal {
    return [[Game instance].homePlayer crystals];
}

@end
