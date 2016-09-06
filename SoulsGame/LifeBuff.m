//
//  LifeBuff.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/8/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "LifeBuff.h"
#import "ElementType.m"

@implementation LifeBuff

-(instancetype)init{
    if (self = [super init]){
        self.amount = 1;
        self.name = @"Life Buff";
        self.type = ElementTypeLife;
        self.desc = @"A basic buff soul. Will increase the power of any life spell.";
        self.img = [UIImage imageNamed:@"light-holy.png"];
        
        self.ID = @"003";
    }
    return self;
}

-(NSString*)effect{
    return [NSString stringWithFormat:@"Life Buff grants +%i life healing", (int)self.amount];
}

-(instancetype)copyWithZone:(NSZone *)zone{
    LifeBuff* theCopy = [[LifeBuff alloc]init];
    
    theCopy.minorBuffApplied = self.minorBuffApplied;
    theCopy.majorBuffApplied = self.majorBuffApplied;
    theCopy.amount = self.amount;
    
    return theCopy;
}

@end
