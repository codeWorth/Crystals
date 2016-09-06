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

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Fire Buff";
        self.type = ElementTypeFire;
        self.desc = @"A basic buff soul. Will increase the power of any fire spell.";
        self.img = [UIImage imageNamed:@"demonfire.jpg"];
        
        self.ID = @"004";
    }
    return self;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Fire Buff grants +%i fire damage", (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    FireBuff* theCopy = [[FireBuff alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
