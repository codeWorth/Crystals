//
//  AirResist.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "AirResist.h"

@implementation AirResist

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Air Resistance";
        self.type = ElementTypeAir;
        self.desc = @"A basic resistance soul. Will block a portion of any incoming air attack";
        self.img = [UIImage imageNamed:@"air.jpg"];
        
        self.ID = @"007";
    }
    return self;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Air Resistance grants %i less air damage taken", (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    AirResist* theCopy = [[AirResist alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
