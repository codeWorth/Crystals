//
//  Spells.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/7/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Spells.h"

#import "QuickHeal.h"
#import "Fireball.h"
#import "WaterBuff.h"
#import "WaterShard.h"
#import "HealingPool.h"

@interface Spells ()

@property (nonatomic, strong) NSArray* spells;

@end

@implementation Spells

static Spells* spellsInstance = nil;

-(instancetype)init{
    if (self = [super init]){
        
        NSMutableArray *addSpells = [[NSMutableArray alloc]init];
        
        [addSpells addObject:[[QuickHeal alloc]init]];
        [addSpells addObject:[[Fireball alloc]init]];
        [addSpells addObject:[[WaterShard alloc]init]];
        [addSpells addObject:[[HealingPool alloc]init]];
        
        self.spells = [addSpells copy];
        
    }
    return self;
}

+(NSArray*)spells{
    if (spellsInstance == nil){
        spellsInstance = [[Spells alloc]init];
    }
    return spellsInstance.spells;
}

+(NSObject<Spell>*)spellWithID:(NSString *)ID{
    if (spellsInstance == nil){
        spellsInstance = [[Spells alloc]init];
    }
    
    for (NSObject<Spell>* spell in spellsInstance.spells){
        if ([spell.ID isEqualToString:ID]){
            return [spell copy];
        }
    }
    
    return nil;
}

@end
