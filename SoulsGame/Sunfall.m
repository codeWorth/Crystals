//
//  Sunfall.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/12/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Sunfall.h"
#import "Crystal.h"
#import "Game.h"
#import "TimedSoul.h"
#import "AllBuff.h"

@implementation Sunfall

-(NSMutableArray*)affectCrystal:(Crystal *)crystal{
    TimedSoul* soul = [[TimedSoul alloc] initWithTime:3 andSoul:[[AllBuff alloc]init]];
    [soul getSoul].amount = self.amount;
    return [NSMutableArray arrayWithObject:soul];
}

-(instancetype)init{
    if (self = [super init]){
        self.type = ElementTypeSun;
        self.positiveEffect = YES;
        self.name = @"Sunfall";
        self.cost = 4;
        self.desc = @"An area of effect spell that provides a small power buff to all friendly minions for 3 turns.";
        self.amount = 1;
        self.flavorText = @"Not to be confused with Skyfall.";
        self.img = [UIImage imageNamed:@"sunfall.jpg"];
        
        self.canTargetEnemies = NO;
        self.canTargetFriendlies = NO;
        
        self.ID = @"001";
    }
    return self;
}

-(instancetype)copyWithZone:(NSZone *)zone{
    Sunfall* theCopy = [[Sunfall alloc]init];
    theCopy.amount = self.amount;
    
    return theCopy;
}

-(NSArray*)targetsForCrystal:(Crystal *)crystal {
    return [[Game instance].homePlayer crystals];
}

@end
