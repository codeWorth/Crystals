//
//  ElementType.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ElementType {
    Fire, //straight high damage
    Water, //heal or damage (choose one)
    Earth, //damage to health pool directly (partially)
    Air, //damage bonus from speed
    Life, //large heals
    Sun, //buffs other minions temporarily
    Moon, //debuff other minions temporarily
    Shadow //area of effect
}ElementType;