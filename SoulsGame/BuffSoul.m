//
//  BuffSoul.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/11/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuffSoul.h"

@implementation BuffSoul

-(void)affectSpell:(Spell *)spell{
    if ([self willEffectSpell:spell]){
        spell.amount += self.amount;
    }
}

-(NSInteger)cost{
    return RESIST_COST;
}

-(NSString*)effect {
    return @"No effects";
}

-(BOOL)willEffectSpell:(Spell *)spell {
    return self.type = spell.type;
}

@end
