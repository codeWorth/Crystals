//
//  SunBuff.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "SunBuff.h"

@implementation SunBuff

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Sun Buff";
        self.type = ElementTypeSun;
        self.desc = @"A basic buff soul. Will increase the power of any Sun spell.";
        self.img = [UIImage imageNamed:@"sun.jpg"];
        
        self.ID = @"014";
    }
    return self;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Sun Buff grants +%i Sun power", (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    SunBuff* theCopy = [[SunBuff alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
