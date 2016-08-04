//
//  FireResist.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "FireResist.h"

@implementation FireResist

@synthesize name;
@synthesize resistAmount;
@synthesize img;
@synthesize type;
@synthesize desc;
@synthesize minorBuffApplied;
@synthesize majorBuffApplied;

-(instancetype)init{
    if (self = [super init]){
        self.minorBuffApplied = NO;
        self.majorBuffApplied = NO;
        
        self.resistAmount = 1;
        self.name = @"Fire Resistance";
        self.type = Fire;
        self.desc = @"A basic resistance soul. Will block a portion of any incoming fire attack";
        self.img = [UIImage imageNamed:@"fireshield.jpg"];
    }
    return self;
}

-(void)applyMinorBuff{
    self.resistAmount += MINOR_BUFF_AMOUNT;
    self.minorBuffApplied = YES;
}

-(void)applyMajorBuff{
    self.resistAmount += MAJOR_BUFF_AMOUNT;
    self.majorBuffApplied = YES;
}

-(void)resistSpell:(NSObject<Spell>*)spell{
    if (spell.type == Fire && !spell.positiveEffect){
        spell.amount -= self.resistAmount;
    }
}

-(NSInteger)cost{
    return RESIST_COST;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Fire Resistance grants %i less fire damage taken", (int)self.resistAmount];
}

@end
