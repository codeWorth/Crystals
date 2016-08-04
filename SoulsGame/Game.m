//
//  Game.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Game.h"
#import "FireResist.h"
#import "Minion.h"
#import "FireBuff.h"
#import "LifeBuff.h"
#import "WaterResist.h"
#import "WaterBuff.h"

#import "Fireball.h"
#import "QuickHeal.h"
#import "WaterShard.h"
#import "HealingPool.h"

@implementation Game

static Game* gameInstance = nil;

-(instancetype)init{
    if (self = [super init]){
        self.time = 0;
        
        self.homePlayer = [[Player alloc]init];
        self.awayPlayer = [[Player alloc]init];
        
        self.homePlayer.mana = 25;//[Game minionCreateCost];
        self.awayPlayer.mana = 25;//[Game minionCreateCost];
        
        self.homeKnownResist = [[NSArray alloc]initWithObjects:[[FireResist alloc]init], [[WaterResist alloc]init], nil];
        self.homeKnownBuff = [[NSArray alloc]initWithObjects:[[FireBuff alloc]init], [[LifeBuff alloc]init], [[WaterBuff alloc]init] ,  nil];
        self.homeKnownSpec = [[NSArray alloc]init];
        
        self.knownSpells = [[NSArray alloc]initWithObjects:[[Fireball alloc]init], [[QuickHeal alloc]init], [[WaterShard alloc]init], [[HealingPool alloc] init], nil];
        
        //REMOVE THIS EVENTUALLY
        self.canAttack = YES;
    }
    return self;
}

-(void)update{
    [self.homePlayer update];
    [self.awayPlayer update];
    
    /*if ([self.homePlayer minCooldown] <= 0){
        if ([self.homePlayer minCooldown] < [self.awayPlayer minCooldown]){
            self.canAttack = YES;
        }
    }
    if ([self.awayPlayer minCooldown] <= 0){
        if ([self.awayPlayer minCooldown] < [self.homePlayer minCooldown]){
            // REVERT THIS EVENTUALLY
            //self.canAttack = NO;
            
            Player* temp = self.homePlayer;
            self.homePlayer = self.awayPlayer;
            self.awayPlayer = temp;
        }
    }*/
}

-(void)homeEndTurn{
    self.time++;
    [self.homePlayer nextTurn];
    
    //REVERT THIS EVENTUALLY
    //self.canAttack = NO;
    
    Player* temp = self.homePlayer;
    self.homePlayer = self.awayPlayer;
    self.awayPlayer = temp;
}

-(void)awayEndTurn{
    self.time++;
    [self.awayPlayer nextTurn];
    
    self.canAttack = YES;
}

+(Game*)instance {
    @synchronized(self) {
        if (gameInstance == nil) {
            gameInstance = [[self alloc] init];
        }
    }
    
    return gameInstance;
}

+(NSInteger)minionCreateCost{
    return 9;
}

@end
