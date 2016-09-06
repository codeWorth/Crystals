//
//  HealingPool.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/8/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "HealingPool.h"
#import "Crystal.h"

@implementation HealingPool

-(NSMutableArray*)affectCrystal:(Crystal *)crystal{
    [crystal removeHealth:self.amount];
    return nil;
}

-(instancetype)init{
    if (self = [super init]){
        self.type = ElementTypeWater;
        self.positiveEffect = YES;
        self.name = @"Healing Pool";
        self.cost = 2;
        self.desc = @"Sooths the target with water, healing 2 health.";
        self.amount = 2;
        self.flavorText = @"But that all changed when the fire nation attacked! ... oh wait wrong universe.";
        self.img = [UIImage imageNamed:@"watersunlight.jpg"];
        
        self.canTargetEnemies = YES;
        self.canTargetFriendlies = YES;
        
        self.ID = @"004";
    }
    return self;
}

-(instancetype)copyWithZone:(NSZone *)zone{
    HealingPool* theCopy = [[HealingPool alloc]init];
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
