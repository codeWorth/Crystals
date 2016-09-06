//
//  EarthBuff.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "EarthBuff.h"

@implementation EarthBuff

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Earth Buff";
        self.type = ElementTypeEarth;
        self.desc = @"A basic buff soul. Will increase the power of any Earth spell.";
        self.img = [UIImage imageNamed:@"obsidian-back.jpg"];
        
        self.ID = @"012";
    }
    return self;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Earth Buff grants +%i Earth power", (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    EarthBuff* theCopy = [[EarthBuff alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
