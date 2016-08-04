//
//  HealingPool.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/8/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "HealingPool.h"
#import "Minion.h"

@interface HealingPool ()

@property (nonatomic) NSInteger _amount;

@end

@implementation HealingPool 

@synthesize type;
@synthesize name;
@synthesize cost;
@synthesize desc;
@synthesize img;
@synthesize flavorText;
@synthesize canTargetFriendlies;
@synthesize canTargetEnemies;
@synthesize positiveEffect;

-(NSMutableArray*)affectMinion:(Minion *)minion{
    [minion removeHealth:self._amount];
    return nil;
}

-(instancetype)init{
    if (self = [super init]){
        self.type = Water;
        self.positiveEffect = YES;
        self.name = @"Healing Pool";
        self.cost = 2;
        self.desc = @"Sooths the target with water, healing 2 health.";
        self._amount = 2;
        self.flavorText = @"But that all changed when the fire nation attacked! ... oh wait wrong universe.";
        self.img = [UIImage imageNamed:@"watersunlight.jpg"];
        
        self.canTargetEnemies = YES;
        self.canTargetFriendlies = YES;
    }
    return self;
}

-(NSInteger)amount{
    return self._amount;
}

-(void)setAmount:(NSInteger)amount{
    self._amount = amount;
    if (self._amount < 0){
        self._amount = 0;
    }
}

@end
