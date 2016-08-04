//
//  WaterShard.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/8/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "WaterShard.h"
#import "Minion.h"

@interface WaterShard ()

@property (nonatomic) NSInteger _amount;

@end

@implementation WaterShard

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
        self.positiveEffect = NO;
        self.name = @"Water Shard";
        self.cost = 2;
        self.desc = @"Shoots a small, concentrated shard of Water, dealing 2 damage";
        self._amount = 2;
        self.flavorText = @"You wouldn't think that getting hit by water would hurt this much.";
        self.img = [UIImage imageNamed:@"ice_spike.jpg"];
        
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
