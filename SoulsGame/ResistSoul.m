//
//  ResistSoul.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/11/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResistSoul.h"

@implementation ResistSoul

-(void)affectSpell:(Spell *)spell{
    if ([self willEffectSpell:spell] && !spell.positiveEffect){
        spell.amount -= self.amount;
    }
}

-(NSString*)effect {
    return @"No effects";
}

-(NSInteger)cost{
    return RESIST_COST;
}

-(BOOL)willEffectSpell:(Spell *)spell {
    return self.type == spell.type;
}

@end
