//
//  QuickHeal.m
//  SoulsGame
//
//  Created by Andrew Cummings on 6/6/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "QuickHeal.h"
#import "Crystal.h"

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
@synthesize ID;

-(NSMutableArray*)affectCrystal:(Crystal *)crystal{
    [crystal addHealth:self._amount];
    return nil;
}

-(instancetype)init{
    if (self = [super init]){
        self.type = Life;
        self.positiveEffect = YES;
        self.name = @"Quick Heal";
        self.cost = 1;
        self.desc = @"An efficent small heal that can be cast on any crystal. Life type spell";
        self._amount = 2;
        self.flavorText = @"I bring life...";
        self.img = [UIImage imageNamed:@"heal.jpg"];
        
        self.canTargetEnemies = YES;
        self.canTargetFriendlies = YES;
        
        self.ID = @"001";
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
    QuickHeal* theCopy = [[QuickHeal alloc]init];
    theCopy.amount = self._amount;
    
    return theCopy;
}

@end
