//
//  Minion.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Minion.h"
#import "Soul.h"
#import "Spell.h"
#import "Player.h"


@interface Minion ()

@property (nonatomic, strong) NSMutableArray* resistSouls;
@property (nonatomic, strong) NSMutableArray* buffSouls;
@property (nonatomic, strong) NSMutableArray* specSouls;

@property (nonatomic, strong) HealthSoul* _health;
@property (nonatomic, strong) SpeedSoul* _speed;
@property (nonatomic, strong) ShieldSoul* _shield;

@property (nonatomic, strong) NSMutableArray* effects;
-(void)applyEffects:(NSObject<Spell>*)spell;

@property (nonatomic) NSInteger affectedCooldown;
@property (nonatomic) NSInteger _cooldown;

@property (nonatomic) NSInteger maxHealth;
@property (nonatomic) NSInteger maxShield;

@end

@implementation Minion

+(double)BASE_STATS_TOTAL{
    return 12;
}

-(instancetype)initWithHealth:(NSInteger)health Speed:(NSInteger)speed shield:(NSInteger)shield{
    if ((self = [super init]) && speed+health+shield == [Minion BASE_STATS_TOTAL]){
        self.isDead = NO;
        
        self._shield = [[ShieldSoul alloc]initWithShield:shield];
        self.maxShield = shield;
        self._health = [[HealthSoul alloc]initWithHealth:health*2];
        self.maxHealth = health*2;
        self._speed = [[SpeedSoul alloc]initWithSpeed:speed];
        
        self.resistSouls = [[NSMutableArray alloc]initWithObjects:[NSNull null], [NSNull null], [NSNull null], nil];
        self.buffSouls = [[NSMutableArray alloc]initWithObjects:[NSNull null], [NSNull null], [NSNull null], [NSNull null], nil];
        self.specSouls = [[NSMutableArray alloc]initWithObjects:[NSNull null], [NSNull null], [NSNull null], nil];
        
        self.affectedCooldown = DEFAULT_COOLDOWN;
        self.affectedCooldown -= (int)(self._speed.amount/2);
        
        self._cooldown = self.affectedCooldown;
    } else {
        NSLog(@"Invalid minion creation stats");
    }
    return self;
}

-(void)applyMajorBuff{
    for (NSObject<ResistSoul>* soul in [self getResistSouls]) {
        if (!soul.majorBuffApplied){
            [soul applyMajorBuff];
        }
    }
    for (NSObject<BuffSoul>* soul in [self getBuffSouls]) {
        if (!soul.majorBuffApplied){
            [soul applyMajorBuff];
        }
    }
    for (NSObject<SpecSoul>* soul in [self getSpecSouls]) {
        if (!soul.majorBuffApplied){
            [soul applyMajorBuff];
        }
    }
}

-(BOOL)shouldApplyMajorBuff{
    return ([self getResistSouls].count == 3 && [self getBuffSouls].count == 4 && [self getSpecSouls].count == 3);
}

-(void)handleSoulsForList:(NSArray*)souls{
    if (souls.count == 3){
        for (NSObject<Soul>* soul in souls) {
            if (!soul.minorBuffApplied){
                [soul applyMinorBuff];
            }
        }
    }
}

-(void)addResistSoul:(NSObject<ResistSoul>*)soul atIndex:(NSInteger)index{
    [self.resistSouls replaceObjectAtIndex:index withObject:soul];
    if ([self getResistSouls].count == 3){
        [self handleSoulsForList:[self getResistSouls]];
    }
    
    if ([self shouldApplyMajorBuff]){
        [self applyMajorBuff];
    }
}

-(void)addBuffSoul:(NSObject<BuffSoul>*)soul atIndex:(NSInteger)index{
    [self.buffSouls replaceObjectAtIndex:index withObject:soul];
    if ([self getBuffSouls].count == 4){
        [self handleSoulsForList:[self getBuffSouls]];
    }
    
    if ([self shouldApplyMajorBuff]){
        [self applyMajorBuff];
    }
}

-(void)addSpecSoul:(NSObject<SpecSoul>*)soul atIndex:(NSInteger)index{
    [self.specSouls replaceObjectAtIndex:index withObject:soul];
    if ([self getSpecSouls].count == 3){
        [self handleSoulsForList:[self getSpecSouls]];
    }
    
    if ([self shouldApplyMajorBuff]){
        [self applyMajorBuff];
    }
}

-(NSArray*)getResistSouls{
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    for (id soul in self.resistSouls){
        if (soul != [NSNull null]){
            [arr addObject:soul];
        }
    }
    return arr;
}

-(NSArray*)getBuffSouls{
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    for (id soul in self.buffSouls){
        if (soul != [NSNull null]){
            [arr addObject:soul];
        }
    }
    return arr;
}

-(NSArray*)getSpecSouls{
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    for (id soul in self.specSouls){
        if (soul != [NSNull null]){
            [arr addObject:soul];
        }
    }
    return arr;
}

-(void)castSpell:(NSObject<Spell> *)spell onTarget:(Minion *)target{
    self._cooldown = self.affectedCooldown;
    
    for (NSObject<BuffSoul>* buff in [self getBuffSouls]) {
        [buff buffSpell:spell];
    }
    
    [target receiveSpell:spell];	
}

-(void)receiveSpell:(NSObject<Spell> *)spell{
    for (NSObject<ResistSoul>* resistance in [self getResistSouls]) {
        [resistance resistSpell:spell];
    }
    
    
    [self.effects addObjectsFromArray:[spell affectMinion:self]];
}

-(void)nextTurn{
    self._cooldown--;
    self._shield.amount++;
    if (self._shield.amount > self.maxShield){
        self._shield.amount = self.maxShield;
    }
    
    for (TimedSoul *soul in self.effects) {
        [soul update];
        if ([soul shouldRemove]){
            [self.effects removeObject:soul];
        }
    }
}

-(BOOL)canCastSpell{
    if ([self cooldown] == 0){
        return true;
    }
    return false;
}

-(void)applyEffects:(NSObject<Spell>*)spell{
    for (TimedSoul* soul in self.effects) {
        if ([[soul getSoul] conformsToProtocol:@protocol(BuffSoul)]){
            NSObject<BuffSoul>* buffSoul = (NSObject<BuffSoul>*)[soul getSoul];
            [buffSoul buffSpell:spell];
        } else if ([[soul getSoul] conformsToProtocol:@protocol(ResistSoul)]){
            NSObject<ResistSoul>* resistSoul = (NSObject<ResistSoul>*)[soul getSoul];
            [resistSoul resistSpell:spell];
        }
    }
}

-(UIImage*)imgDesc{
    if ([self getResistSouls].count + [self getBuffSouls].count + [self getSpecSouls].count == 0){
        UIImage* img = [UIImage imageNamed:@"crystal.jpg"];
        return img;
    } else {
        UIImage* img = [UIImage imageNamed:@"crystal wip.jpg"];
        return img;
    }
}

-(NSInteger)health{
    return self._health.amount;
}

-(NSInteger)cooldown{
    if (self._cooldown < 0){
        return 0;
    } else {
        return self._cooldown;
    }
}

-(NSInteger)shield{
    return self._shield.amount;
}

-(NSInteger)speed{
    return self._speed.amount;
}

-(void)addHealth:(NSInteger)heal{
    NSInteger remainingHeal = heal + self._health.amount - self.maxHealth;
    if (remainingHeal > 0){
        self._health.amount = self.maxHealth;
        self._shield.amount += remainingHeal;
        if (self._shield.amount > self.maxShield){
            self._shield.amount = self.maxShield;
        }
    } else {
        self._health.amount += heal;
    }
}

-(void)removeHealth:(NSInteger)damage{
    NSInteger remaniningDamage = damage - self._shield.amount;
    if (remaniningDamage > 0){
        self._shield.amount = 0;
        self._health.amount -= remaniningDamage;
        if (self._health.amount <= 0){
            NSLog(@"DED");
            self.isDead = YES;
        }
    } else {
        self._shield.amount -= damage;
    }
}

-(NSArray*)getAllSouls{
    return [[self.resistSouls arrayByAddingObjectsFromArray:self.buffSouls] arrayByAddingObjectsFromArray:self.specSouls];
}

-(void)addSoul:(NSObject<Soul> *)soul atIndex:(NSInteger)index{
    if ([soul conformsToProtocol:@protocol(ResistSoul)]){
        [self addResistSoul:(NSObject<ResistSoul>*)soul atIndex:index];
    } else if ([soul conformsToProtocol:@protocol(BuffSoul)]){
        [self addBuffSoul:(NSObject<BuffSoul>*)soul atIndex:index-3];
    } else if ([soul conformsToProtocol:@protocol(SpecSoul)]){
        [self addSpecSoul:(NSObject<SpecSoul>*)soul atIndex:index-7];
    }
}

-(id)getSoulAtIndex:(NSInteger)index{
    return [[self getAllSouls] objectAtIndex:index];
}

-(NSInteger)realCooldown{
    return self._cooldown;
}

-(NSArray*)effectsOnSpell:(NSObject<Spell>*)spell{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    
    for (NSObject<ResistSoul>* soul in [self getResistSouls]) {
        if (soul.type == spell.type){
            [array addObject:soul.effect];
        }
    }
    
    for (NSObject<BuffSoul>* soul in [self getBuffSouls]) {
        if (soul.type == spell.type){
            [array addObject:soul.effect];
        }
    }
    
    return array;
}

@end
