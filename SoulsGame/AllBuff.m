//
//  AllBuff.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/12/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "AllBuff.h"

@implementation AllBuff

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Spell Buff";
        self.type = ElementTypeNone;
        self.desc = @"Error. Should not be displayed.";
        self.img = nil;
        
        self.ID = @"006";
    }
    return self;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Spell Buff grants +%d power on all spells.", (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    AllBuff* theCopy = [[AllBuff alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

-(void)affectSpell:(Spell*)spell {
    spell.amount += self.amount;
}

-(BOOL)willEffectSpell:(Spell *)spell {
    return YES;
}

@end
