//
//  Minion.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Minion.h"

#import "ResistSoul.h"
#import "BuffSoul.h"
#import "SpecSoul.h"

#import "HealthSoul.h"
#import "SpeedSoul.h"
#import "ShieldSoul.h"
#import "TimedSoul.h"

@class Player;

#define DEFAULT_COOLDOWN 7;

@interface Minion : NSObject

@property (nonatomic) BOOL isDead;

-(instancetype)initWithHealth:(NSInteger)health Speed:(NSInteger)speed shield:(NSInteger)shield;

-(void)addResistSoul:(NSObject<ResistSoul>*)soul atIndex:(NSInteger)index;
-(void)addBuffSoul:(NSObject<BuffSoul>*)soul atIndex:(NSInteger)index;
-(void)addSpecSoul:(NSObject<SpecSoul>*)soul atIndex:(NSInteger)index;
-(void)addSoul:(NSObject<Soul>*)soul atIndex:(NSInteger)index;

-(NSArray*)getResistSouls;
-(NSArray*)getBuffSouls;
-(NSArray*)getSpecSouls;
-(id)getSoulAtIndex:(NSInteger)index;

-(void)castSpell:(NSObject<Spell>*)spell onTarget:(Minion*)target;
-(void)receiveSpell:(NSObject<Spell>*)spell;

-(void)nextTurn;

-(BOOL)canCastSpell;

-(UIImage*)imgDesc;

-(void)addHealth:(NSInteger)heal;
-(void)removeHealth:(NSInteger)damage;
-(NSInteger)health;
-(NSInteger)cooldown;
-(NSInteger)shield;
-(NSInteger)speed;

-(NSInteger)realCooldown;

-(NSArray*)effectsOnSpell:(NSObject<Spell>*)spell;

@end
