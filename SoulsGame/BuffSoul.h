//
//  BuffSoul.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Spell.h"
#import "Soul.h"

@protocol BuffSoul <Soul>

@property (nonatomic) NSInteger buffAmount;
@property (nonatomic) enum ElementType type;

-(void)buffSpell:(NSObject<Spell>*)spell;
-(NSString*)effect;

@end
