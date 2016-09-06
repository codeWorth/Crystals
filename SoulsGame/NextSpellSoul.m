//
//  NextSpellSoul.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "NextSpellSoul.h"

@interface NextSpellSoul ()

@property (nonatomic, strong) Soul* soul;
@property (nonatomic) BOOL used;

@end

@implementation NextSpellSoul

-(instancetype)initWithSoul:(Soul *)soul{
    if (self = [super init]){
        self.soul = soul;
        self.used = NO;
    }
    return self;
}

-(void)turnUpdate {
}

-(BOOL)shouldRemove{
    return self.used;
}

-(Soul*)getSoul{
    if (self.used) {
        return nil;
    }
    
    return self.soul;
}

-(void)updateCrystalDied:(Crystal *)crystal {
    
}

-(void)updateSpellCast:(Spell *)spell fromSource:(Crystal *)source toTarget:(Crystal*)target {
    self.used = YES;
}

-(void)updateCrystalSummoned:(Crystal *)crystal {
    
}

@end
