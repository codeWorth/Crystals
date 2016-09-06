//
//  WaterShard.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/8/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "WaterShard.h"
#import "Crystal.h"

@implementation WaterShard

-(NSMutableArray*)affectCrystal:(Crystal *)crystal{
    [crystal removeHealth:self.amount];
    return nil;
}

-(instancetype)init{
    if (self = [super init]){
        self.type = ElementTypeWater;
        self.positiveEffect = NO;
        self.name = @"Water Shard";
        self.cost = 2;
        self.desc = @"Shoots a small, concentrated shard of Water, dealing 2 damage";
        self.amount = 2;
        self.flavorText = @"You wouldn't think that getting hit by water would hurt this much.";
        self.img = [UIImage imageNamed:@"ice_spike.jpg"];
        
        self.canTargetEnemies = YES;
        self.canTargetFriendlies = YES;
        
        self.ID = @"003";
    }
    return self;
}

-(instancetype)copyWithZone:(NSZone *)zone{
    WaterShard* theCopy = [[WaterShard alloc]init];
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
