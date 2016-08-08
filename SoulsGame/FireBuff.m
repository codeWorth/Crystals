//
//  FireBuff.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/8/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "FireBuff.h"
#import "ElementType.m"

@implementation FireBuff

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
        self.name = @"Fire Buff";
        self.type = Fire;
        self.desc = @"A basic buff soul. Will increase the power of any fire spell.";
        self.img = [UIImage imageNamed:@"demonfire.jpg"];
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
    if (spell.type == Fire){
        spell.amount += self.buffAmount;
    }
}

-(NSInteger)cost{
    return RESIST_COST;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Fire Buff grants +%i fire damage", (int)self.buffAmount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    FireBuff* theCopy = [[FireBuff alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.buffAmount = self.buffAmount;
    
    return theCopy;
}

@end
