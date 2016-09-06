
//
//  MoonResist.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "MoonResist.h"

@implementation MoonResist

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Moon Resistance";
        self.type = ElementTypeMoon;
        self.desc = @"A basic resistance soul. Will block a portion of any incoming moon attack";
        self.img = [UIImage imageNamed:@"moon.jpg"];
        
        self.ID = @"010";
    }
    return self;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Moon Resistance grants %i less moon damage taken", (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    MoonResist* theCopy = [[MoonResist alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
