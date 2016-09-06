//
//  Spell.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/12/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Spell.h"

@interface Spell ()

@property (nonatomic) NSInteger _amount;

@end

@implementation Spell

-(NSInteger)amount {
    return self._amount;
}

-(void)setAmount:(NSInteger)amount {
    if (amount < 0) {
        amount = 0;
    }
    
    self._amount = amount;
}

-(NSMutableArray*)affectCrystal:(Crystal*)crystal {
    return nil;
}

-(NSArray*)targetsForCrystal:(Crystal *)crystal {
    return [NSArray arrayWithObject:crystal];
}

@end
