//
//  FireResist.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "FireResist.h"

@implementation FireResist

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Fire Resistance";
        self.type = ElementTypeFire;
        self.desc = @"A basic resistance soul. Will block a portion of any incoming fire attack";
        self.img = [UIImage imageNamed:@"fireshield.jpg"];
        
        self.ID = @"001";
    }
    return self;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Fire Resistance grants %i less fire damage taken", (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    FireResist* theCopy = [[FireResist alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
