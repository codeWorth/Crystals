//
//  FireSpell.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Fireball.h"
#import "Crystal.h"

@interface Fireball ()

@property (nonatomic) NSInteger _amount;

@end

@implementation Fireball

@synthesize type;
@synthesize name;
@synthesize cost;
@synthesize desc;
@synthesize img;
@synthesize flavorText;
@synthesize canTargetFriendlies;
@synthesize canTargetEnemies;
@synthesize positiveEffect;
@synthesize ID;

-(NSMutableArray*)affectCrystal:(Crystal *)crystal{
    [crystal removeHealth:self._amount];
    return nil;
}

-(instancetype)init{
    if (self = [super init]){
        self.type = Fire;
        self.positiveEffect = NO;
        self.name = @"Fireball";
        self.cost = 2;
        self.desc = @"Launches a ball of fire towards an enemy, dealing 3 points of fire damage";
        self._amount = 3;
        self.flavorText = @"A giant orb of fire flying towards your foe at a remarkable speed: simple but effective.";
        self.img = [UIImage imageNamed:@"Fireball.jpg"];
        
        self.canTargetEnemies = YES;
        self.canTargetFriendlies = YES;
        
        self.ID = @"002";
    }
    return self;
}

-(NSInteger)amount{
    return self._amount;
}

-(void)setAmount:(NSInteger)amount{
    if (amount < 0){
        amount = 0;
    }
    self._amount = amount;
}

-(instancetype)copyWithZone:(NSZone *)zone{
    Fireball* theCopy = [[Fireball alloc]init];
    theCopy.amount = self._amount;
    
    return theCopy;
}

@end
