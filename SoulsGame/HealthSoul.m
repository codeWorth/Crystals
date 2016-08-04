//
//  HealthSoul.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "HealthSoul.h"

@implementation HealthSoul

@synthesize name;
@synthesize img;
@synthesize amount;
@synthesize desc;
@synthesize minorBuffApplied;
@synthesize majorBuffApplied;

-(instancetype)initWithHealth:(NSInteger)health{
    if (self = [super init]){
        self.minorBuffApplied = NO;
        self.majorBuffApplied = NO;
        
        self.amount = health;
        self.name = @"Health";
        self.desc = @"Amount of health that this minion has.";
    }
    return self;
}

-(void)affectSpell:(NSObject<Spell> *)spell{
    
}

-(void)applyMinorBuff{
    self.amount += MINOR_BUFF_AMOUNT;
    self.minorBuffApplied = YES;
}

-(void)applyMajorBuff{
    self.amount += MAJOR_BUFF_AMOUNT;
    self.majorBuffApplied = YES;
}

-(NSInteger)cost{
    return 0;
}

@end
