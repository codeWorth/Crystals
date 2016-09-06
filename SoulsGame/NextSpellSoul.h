//
//  NextSpellSoul.h
//  SoulsGame
//
//  Created by Andrew Cummings on 8/13/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EffectSoul.h"
#import "Soul.h"

@interface NextSpellSoul : NSObject <EffectSoul>

-(instancetype)initWithSoul:(Soul*)soul;

@end
