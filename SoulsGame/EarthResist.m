//
//  EarthResist.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "EarthResist.h"

@implementation EarthResist

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Earth Resistance";
        self.type = ElementTypeEarth;
        self.desc = @"A basic resistance soul. Will block a portion of any incoming earth attack";
        self.img = [UIImage imageNamed:@"rockshield.png"];
        
        self.ID = @"006";
    }
    return self;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Earth Resistance grants %i less earth damage taken", (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    EarthResist* theCopy = [[EarthResist alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
