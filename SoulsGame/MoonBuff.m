//
//  MoonBuff.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "MoonBuff.h"

@implementation MoonBuff

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Moon Buff";
        self.type = ElementTypeMoon;
        self.desc = @"A basic buff soul. Will increase the power of any Moon spell.";
        self.img = [UIImage imageNamed:@"moonbuff.jpg"];
        
        self.ID = @"015";
    }
    return self;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Moon Buff grants +%i Moon power", (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    MoonBuff* theCopy = [[MoonBuff alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
