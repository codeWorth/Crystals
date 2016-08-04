//
//  ActiveSoul.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Soul.h"

@protocol SpecSoul <Soul>

@property (nonatomic) enum ElementType type;

@end
