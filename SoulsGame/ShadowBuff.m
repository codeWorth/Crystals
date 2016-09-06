//
//  ShadowBuff.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "ShadowBuff.h"

@implementation ShadowBuff

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Shadow Buff";
        self.type = ElementTypeShadow;
        self.desc = @"A basic buff soul. Will increase the power of any Shadow spell.";
        self.img = [UIImage imageNamed:@"shadowbuff.png"];
        
        self.ID = @"016";
    }
    return self;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Shadow Buff grants +%i Shadow power", (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    ShadowBuff* theCopy = [[ShadowBuff alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
