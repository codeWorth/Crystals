//
//  Soul.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/11/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Soul.h"

@implementation Soul

-(instancetype)init {
    if (self = [super init]) {
        self.minorBuffApplied = NO;
        self.majorBuffApplied = NO;
    }
    return self;
}

-(void)applyMinorBuff {
    self.amount += MINOR_BUFF_AMOUNT;
    self.minorBuffApplied = YES;
}

-(void)applyMajorBuff {
    self.amount += MAJOR_BUFF_AMOUNT;
    self.majorBuffApplied = YES;
}

-(NSInteger)cost {
    return 0;
}

-(void)affectSpell:(Spell*)spell {
    
}

-(BOOL)willEffectSpell:(Spell *)spell {
    return NO;
}

-(NSString*)effect {
    return @"";
}

@end