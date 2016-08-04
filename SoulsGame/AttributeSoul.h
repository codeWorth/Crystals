//
//  AttributeSoul.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Soul.h"
#import "Spell.h"

@protocol AttributeSoul <Soul>

@property (nonatomic) NSInteger amount;

-(void)affectSpell:(NSObject<Spell>*)spell;

@end
