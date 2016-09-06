//
//  TimedSoul.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/29/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Soul.h"
#import "EffectSoul.h"

@interface TimedSoul : NSObject <EffectSoul>

-(instancetype)initWithTime:(NSInteger)time andSoul:(Soul*)soul;

@end
