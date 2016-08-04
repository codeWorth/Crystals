//
//  SpeedSoul.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "SpeedSoul.h"

@implementation SpeedSoul

@synthesize name;
@synthesize img;
@synthesize amount;
@synthesize desc;
@synthesize minorBuffApplied;
@synthesize majorBuffApplied;

-(instancetype)initWithSpeed:(NSInteger)speed{
    if (self = [super init]){
        self.minorBuffApplied = NO;
        self.majorBuffApplied = NO;
        
        self.amount = speed;
        self.name = @"Speed";
        self.desc = @"How quickly this minion can attack.";
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
