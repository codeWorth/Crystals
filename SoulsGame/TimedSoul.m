//
//  TimedSoul.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/29/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "TimedSoul.h"

@interface TimedSoul ()

@property (nonatomic, strong) Soul* soul;
@property (nonatomic) NSInteger timeLeft;

@end

@implementation TimedSoul

-(instancetype)initWithTime:(NSInteger)time andSoul:(Soul *)soul{
    if (self = [super init]){
        self.timeLeft = time;
        self.soul = soul;
    }
    return self;
}

-(void)turnUpdate {
    if (self.timeLeft > 0){
        self.timeLeft--;
    }
}

-(BOOL)shouldRemove{
    return self.timeLeft == 0;
}

-(Soul*)getSoul{
    return self.soul;
}

-(void)updateCrystalDied:(Crystal *)crystal {
    
}

-(void)updateSpellCast:(Spell *)spell fromSource:(Crystal *)source toTarget:(Crystal*)target {
    
}

-(void)updateCrystalSummoned:(Crystal *)crystal {
    
}

@end
