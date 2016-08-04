//
//  QuickHeal.m
//  SoulsGame
//
//  Created by Andrew Cummings on 6/6/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "QuickHeal.h"
#import "Minion.h"

@interface QuickHeal ()

@property (nonatomic) NSInteger _amount;

@end

@implementation QuickHeal

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
    [minion addHealth:self._amount];
    return nil;
}

-(instancetype)init{
    if (self = [super init]){
        self.type = Life;
        self.positiveEffect = YES;
        self.name = @"Quick Heal";
        self.cost = 1;
        self.desc = @"An efficent small heal that can be cast on any minion. Life type spell";
        self._amount = 2;
        self.flavorText = @"I bring life...";
        self.img = [UIImage imageNamed:@"heal.jpg"];
        
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
