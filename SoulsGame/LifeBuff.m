//
//  LifeBuff.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/8/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "LifeBuff.h"
#import "ElementType.m"
#import "Spell.h"

@implementation LifeBuff

@synthesize name;
@synthesize buffAmount;
@synthesize img;
@synthesize type;
@synthesize desc;
@synthesize minorBuffApplied;
@synthesize majorBuffApplied;

-(instancetype)init{
    if (self = [super init]){
        self.minorBuffApplied = NO;
        self.majorBuffApplied = NO;
        
        self.buffAmount = 1;
        self.name = @"Life Buff";
        self.type = Life;
        self.desc = @"A basic buff soul. Will increase the power of any life spell.";
        self.img = [UIImage imageNamed:@"light-holy.png"];
    }
    return self;
}

-(void)applyMinorBuff{
    self.buffAmount += MINOR_BUFF_AMOUNT;
    self.minorBuffApplied = YES;
}

-(void)applyMajorBuff{
    self.buffAmount += MAJOR_BUFF_AMOUNT;
    self.majorBuffApplied = YES;
}

-(void)buffSpell:(NSObject<Spell>*)spell{
    if (spell.type == Life){
        spell.amount += self.buffAmount;
    }
}

-(NSInteger)cost{
    return RESIST_COST;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Life Buff grants +%i life healing", (int)self.buffAmount];
}

@end
