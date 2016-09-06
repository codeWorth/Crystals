//
//  AirBuff.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "AirBuff.h"

@implementation AirBuff

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Air Buff";
        self.type = ElementTypeAir;
        self.desc = @"A basic buff soul. Will increase the power of any Air spell.";
        self.img = [UIImage imageNamed:@"airbuff.jpg"];
        
        self.ID = @"013";
    }
    return self;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Air Buff grants +%i Air power", (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    AirBuff* theCopy = [[AirBuff alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
