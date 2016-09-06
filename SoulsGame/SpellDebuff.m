//
//  NextSpellDebuff.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "SpellDebuff.h"
#import "Spell.h"
#import "Soul.h"
#import "EffectSoul.h"

@implementation SpellDebuff

-(instancetype)init{
    if (self = [super init]){
        self.amount = 3;
        self.name = @"Spell Debuff";
        self.type = ElementTypeNone;
        self.desc = @"Error. Should not be displayed.";
        self.img = nil;
        
        self.ID = @"006";
    }
    return self;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Spell Debuff grants -%d power on all spells.", (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    SpellDebuff* theCopy = [[SpellDebuff alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

-(void)affectSpell:(Spell*)spell {
    spell.amount -= self.amount;
}

-(BOOL)willEffectSpell:(Spell *)spell {
    return YES;
}

@end
