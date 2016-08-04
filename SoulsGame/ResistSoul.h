//
//  ResistSoul.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Spell.h"
#import "Soul.h"

@protocol ResistSoul <Soul>

@property (nonatomic) NSInteger resistAmount;
@property (nonatomic) enum ElementType type;

-(void)resistSpell:(NSObject<Spell>*)spell;
-(NSString*)effect;

@end
