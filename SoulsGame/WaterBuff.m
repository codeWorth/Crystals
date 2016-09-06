//
//  WaterBuff.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/8/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "WaterBuff.h"

@implementation WaterBuff

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        
        self.name = @"Water Buff";
        self.type = ElementTypeWater;
        self.desc = @"A basic buff soul. Will increase the power of any water spell.";
        self.img = [UIImage imageNamed:@"healingwater.jpg"];
        
        self.ID = @"005";
    }
    return self;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Water Buff grants +%i water damage and healing", (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    WaterBuff* theCopy = [[WaterBuff alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
