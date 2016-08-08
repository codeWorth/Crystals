//
//  WaterBuff.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/8/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "WaterBuff.h"

@implementation WaterBuff

@synthesize name;
@synthesize buffAmount;
@synthesize img;
@synthesize type;
@synthesize desc;
@synthesize minorBuffApplied;
@synthesize majorBuffApplied;
@synthesize ID;

-(instancetype)init{
    if (self = [super init]){
        self.minorBuffApplied = NO;
        self.majorBuffApplied = NO;
        
        self.buffAmount = 1;
        self.name = @"Water Buff";
        self.type = Water;
        self.desc = @"A basic buff soul. Will increase the power of any water spell.";
        self.img = [UIImage imageNamed:@"healingwater.jpg"];
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
    if (spell.type == Water){
        spell.amount += self.buffAmount;
    }
}

-(NSInteger)cost{
    return RESIST_COST;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Water Buff grants +%i water damage and healing", (int)self.buffAmount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    WaterBuff* theCopy = [[WaterBuff alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.buffAmount = self.buffAmount;
    
    return theCopy;
}

@end
