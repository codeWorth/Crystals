//
//  Spells.h
//  SoulsGame
//
//  Created by Andrew Cummings on 8/7/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Spell.h"

@interface Spells : NSObject

+(NSArray*)spells;

+(NSObject<Spell>*)spellWithID:(NSString*)ID;

@end
