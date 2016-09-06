//
//  EffectSoul.h
//  SoulsGame
//
//  Created by Andrew Cummings on 8/12/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Game;
@class Crystal;
@class Soul;

#import "Spell.h"

@protocol EffectSoul <NSObject>

-(BOOL)shouldRemove;
-(void)turnUpdate;
-(Soul*)getSoul;

-(void)updateSpellCast:(Spell *)spell fromSource:(Crystal *)source toTarget:(Crystal*)target;
-(void)updateCrystalSummoned:(Crystal *)crystal;
-(void)updateCrystalDied:(Crystal *)crystal;

@end
