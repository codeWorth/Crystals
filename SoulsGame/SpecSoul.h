//
//  ActiveSoul.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Soul.h"
#import "ElementType.m"

@interface SpecSoul : Soul

@property (nonatomic, assign) ElementType type;

@end
