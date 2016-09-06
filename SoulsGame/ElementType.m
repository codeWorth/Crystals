//
//  ElementType.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ElementType) {
    ElementTypeFire = 0, //straight high damage
    ElementTypeWater = 1, //heal or damage (choose one)
    ElementTypeEarth = 2, //damage to health pool directly (partially)
    ElementTypeAir = 3, //damage bonus from speed
    ElementTypeLife = 4, //large heals
    ElementTypeSun = 5, //buffs other crystals temporarily
    ElementTypeMoon = 6, //debuff other crystals temporarily
    ElementTypeShadow = 7, //area of effect
    ElementTypeNone = 8 //type for misc
};