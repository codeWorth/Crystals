//
//  Player.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Player.h"

@implementation Player

-(instancetype)init{
    if (self = [super init]){
        self.mana = 0;
        
        self.profileImg = [UIImage imageNamed:@"defaultProfile.png"];
        self.username = [NSString stringWithFormat:@"user%i",arc4random_uniform(100)];
    }
    return self;
}

-(void)update{
    [self checkMinionDeath];
}

-(void)nextTurn{
    [self.minion1 nextTurn];
    [self.minion2 nextTurn];
    [self.minion3 nextTurn];
    [self.minion4 nextTurn];
    [self.minion5 nextTurn];
    
    if (self.mana < MAX_MANA){
        self.mana += 1;
    }
}

-(void)checkMinionDeath{
    if (self.minion1.isDead){
        self.minion1 = nil;
    } else if (self.minion2.isDead){
        self.minion2 = nil;
    } else if (self.minion3.isDead){
        self.minion3 = nil;
    } else if (self.minion4.isDead){
        self.minion4 = nil;
    } else if (self.minion5.isDead){
        self.minion5 = nil;
    }
}

-(NSInteger)minCooldown{
    NSInteger minCooldown = 1;
    
    if ([self.minion1 realCooldown] < minCooldown && self.minion1 != nil){
        minCooldown = [self.minion1 realCooldown];
    }
    if ([self.minion2 realCooldown] < minCooldown && self.minion2 != nil){
        minCooldown = [self.minion2 realCooldown];
    }
    if ([self.minion3 realCooldown] < minCooldown && self.minion3 != nil){
        minCooldown = [self.minion3 realCooldown];
    }
    if ([self.minion4 realCooldown] < minCooldown && self.minion4 != nil){
        minCooldown = [self.minion4 realCooldown];
    }
    if ([self.minion5 realCooldown] < minCooldown && self.minion5 != nil){
        minCooldown = [self.minion5 realCooldown];
    }
    return minCooldown;
}

@end

