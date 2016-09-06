//
//  QuickHeal.m
//  SoulsGame
//
//  Created by Andrew Cummings on 6/6/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "QuickHeal.h"
#import "Crystal.h"

@implementation QuickHeal

-(NSMutableArray*)affectCrystal:(Crystal *)crystal{
    [crystal addHealth:self.amount];
    return nil;
}

-(instancetype)init{
    if (self = [super init]){
        self.type = ElementTypeLife;
        self.positiveEffect = YES;
        self.name = @"Quick Heal";
        self.cost = 1;
        self.desc = @"An efficent small heal that can be cast on any crystal. Life type spell";
        self.amount = 2;
        self.flavorText = @"I bring life...";
        self.img = [UIImage imageNamed:@"heal.jpg"];
        
        self.canTargetEnemies = YES;
        self.canTargetFriendlies = YES;
        
        self.ID = @"001";
    }
    return self;
}

-(instancetype)copyWithZone:(NSZone *)zone{
    QuickHeal* theCopy = [[QuickHeal alloc]init];
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
