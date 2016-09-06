//
//  FireSpell.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Fireball.h"
#import "Crystal.h"

@implementation Fireball

-(NSMutableArray*)affectCrystal:(Crystal *)crystal{
    [crystal removeHealth:self.amount];
    return nil;
}

-(instancetype)init{
    if (self = [super init]){
        self.type = ElementTypeFire;
        self.positiveEffect = NO;
        self.name = @"Fireball";
        self.cost = 2;
        self.desc = @"Launches a ball of fire towards an enemy, dealing 3 points of fire damage";
        self.amount = 3;
        self.flavorText = @"A giant orb of fire flying towards your foe at a remarkable speed: simple but effective.";
        self.img = [UIImage imageNamed:@"Fireball.jpg"];
        
        self.canTargetEnemies = YES;
        self.canTargetFriendlies = YES;
        
        self.ID = @"002";
    }
    return self;
}

-(instancetype)copyWithZone:(NSZone *)zone{
    Fireball* theCopy = [[Fireball alloc]init];
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
