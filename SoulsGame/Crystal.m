//
//  Crystal.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Crystal.h"
#import "Soul.h"
#import "Spell.h"
#import "Player.h"

@interface Crystal ()

@property (nonatomic, strong) NSMutableArray* resistSouls;
@property (nonatomic, strong) NSMutableArray* buffSouls;
@property (nonatomic, strong) NSMutableArray* specSouls;

@property (nonatomic, strong) HealthSoul* _health;
@property (nonatomic, strong) SpeedSoul* _speed;
@property (nonatomic, strong) ShieldSoul* _shield;

@property (nonatomic, strong) NSMutableArray* effects;
-(void)applyEffects:(Spell*)spell;

@property (nonatomic) NSInteger affectedCooldown;
@property (nonatomic) NSInteger _cooldown;

@property (nonatomic) NSInteger maxHealth;
@property (nonatomic) NSInteger maxShield;

@property (nonatomic, strong) NSObject<NetComm>* delegate;

@end

@implementation Crystal

+(double)BASE_STATS_TOTAL{
    return 12;
}

-(instancetype)initWithHealth:(NSInteger)health Speed:(NSInteger)speed shield:(NSInteger)shield{
    if ((self = [super init]) && speed+health+shield == [Crystal BASE_STATS_TOTAL]){
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
        NSLog(@"Invalid crystal creation stats");
    }
    return self;
}

-(void)applyMajorBuff{
    for (ResistSoul* soul in [self getResistSouls]) {
        if (!soul.majorBuffApplied){
            [soul applyMajorBuff];
        }
    }
    for (BuffSoul* soul in [self getBuffSouls]) {
        if (!soul.majorBuffApplied){
            [soul applyMajorBuff];
        }
    }
    for (SpecSoul* soul in [self getSpecSouls]) {
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
        for (Soul* soul in souls) {
            if (!soul.minorBuffApplied){
                [soul applyMinorBuff];
            }
        }
    }
}

-(void)addResistSoul:(ResistSoul*)soul atIndex:(NSInteger)index{
    [self.resistSouls replaceObjectAtIndex:index withObject:soul];
    [self.parent addedSoul:soul toTarget:self];
    
    if ([self getResistSouls].count == 3){
        [self handleSoulsForList:[self getResistSouls]];
    }
    
    if ([self shouldApplyMajorBuff]){
        [self applyMajorBuff];
    }
}

-(void)addBuffSoul:(BuffSoul*)soul atIndex:(NSInteger)index{
    [self.buffSouls replaceObjectAtIndex:index withObject:soul];
    [self.parent addedSoul:soul toTarget:self];
    
    if ([self getBuffSouls].count == 4){
        [self handleSoulsForList:[self getBuffSouls]];
    }
    
    if ([self shouldApplyMajorBuff]){
        [self applyMajorBuff];
    }
}

-(void)addSpecSoul:(SpecSoul*)soul atIndex:(NSInteger)index{
    [self.specSouls replaceObjectAtIndex:index withObject:soul];
    [self.parent addedSoul:soul toTarget:self];
    
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

-(void)castSpell:(Spell *)spell onTarget:(Crystal*)target{
    self._cooldown = self.affectedCooldown;
    [self.parent spellCast:spell fromSource:self toTarget:target];
    
    for (BuffSoul* buff in [self getBuffSouls]) {
        [buff affectSpell:spell];
    }
    
    [self applyEffects:spell];
    for (NSObject<EffectSoul>* soul in self.effects) {
        [soul updateSpellCast:spell fromSource:self toTarget:target];
    }
    
    NSArray* targets = [spell targetsForCrystal:target];
    
    for (Crystal* target in targets) {
        [target receiveSpell:spell];
    }
}

-(void)applyEffects:(Spell*)spell{
    for (NSObject<EffectSoul>* soul in self.effects) {
        if ([[soul getSoul] isKindOfClass:[BuffSoul class]]){
            BuffSoul* buffSoul = (BuffSoul*)[soul getSoul];
            [buffSoul affectSpell:spell];
        } else if ([[soul getSoul] isKindOfClass:[SpecSoul class]]){
            ResistSoul* resistSoul = (ResistSoul*)[soul getSoul];
            [resistSoul affectSpell:spell];
        }
    }
}

-(void)receiveSpell:(Spell *)spell{
    for (ResistSoul* resistance in [self getResistSouls]) {
        [resistance affectSpell:spell];
    }
    
    [self applyEffects:spell];
    
    [self.effects addObjectsFromArray:[spell affectCrystal:self]];
}

-(void)nextTurn{
    self._cooldown--;
    self._shield.amount++;
    if (self._shield.amount > self.maxShield){
        self._shield.amount = self.maxShield;
    }
    
    for (NSObject<EffectSoul> *soul in self.effects) {
        [soul turnUpdate];
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

-(void)addSoul:(Soul *)soul atIndex:(NSInteger)index{
    if ([soul isKindOfClass:[ResistSoul class]]){
        [self addResistSoul:(ResistSoul*)soul atIndex:index];
    } else if ([soul isKindOfClass:[BuffSoul class]]){
        [self addBuffSoul:(BuffSoul*)soul atIndex:index-3];
    } else if ([soul isKindOfClass:[SpecSoul class]]){
        [self addSpecSoul:(SpecSoul*)soul atIndex:index-7];
    }
}

-(void)addSoulInEmptyIndex:(Soul *)soul {
    if ([soul isKindOfClass:[ResistSoul class]]){
        if ([self getSoulAtIndex:0] == [NSNull null]) {
            [self addResistSoul:(ResistSoul*)soul atIndex:0];
        } else if ([self getSoulAtIndex:1] == [NSNull null]) {
            [self addResistSoul:(ResistSoul*)soul atIndex:1];
        } else if ([self getSoulAtIndex:2] == [NSNull null]) {
            [self addResistSoul:(ResistSoul*)soul atIndex:2];
        } else {
            return;
        }
    
    } else if ([soul isKindOfClass:[BuffSoul class]]){
        if ([self getSoulAtIndex:3] == [NSNull null]) {
            [self addBuffSoul:(BuffSoul*)soul atIndex:0];
        } else if ([self getSoulAtIndex:4] == [NSNull null]) {
            [self addBuffSoul:(BuffSoul*)soul atIndex:1];
        } else if ([self getSoulAtIndex:5] == [NSNull null]) {
            [self addBuffSoul:(BuffSoul*)soul atIndex:2];
        } else if ([self getSoulAtIndex:6] == [NSNull null]) {
            [self addBuffSoul:(BuffSoul*)soul atIndex:3];
        } else {
            return;
        }
    } else if ([soul isKindOfClass:[SpecSoul class]]){
        if ([self getSoulAtIndex:7] == [NSNull null]) {
            [self addSpecSoul:(SpecSoul*)soul atIndex:0];
        } else if ([self getSoulAtIndex:8] == [NSNull null]) {
            [self addSpecSoul:(SpecSoul*)soul atIndex:1];
        } else if ([self getSoulAtIndex:9] == [NSNull null]) {
            [self addSpecSoul:(SpecSoul*)soul atIndex:2];
        } else {
            return;
        }
    }
}

-(id)getSoulAtIndex:(NSInteger)index{
    return [[self getAllSouls] objectAtIndex:index];
}

-(NSInteger)realCooldown{
    return self._cooldown;
}

-(NSArray*)effectsOnSpell:(Spell*)spell{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    
    for (ResistSoul* soul in [self getResistSouls]) {
        if ([soul willEffectSpell:spell]){
            [array addObject:[soul effect]];
        }
    }
    
    for (BuffSoul* soul in [self getBuffSouls]) {
        if ([soul willEffectSpell:spell]){
            [array addObject:[soul effect]];
        }
    }
    
    for (NSObject<EffectSoul>* effect in self.effects) {
        Soul* soul = [effect getSoul];
        
        if ([soul willEffectSpell:spell]) {
            [array addObject:[soul effect]];
        }
    }
    
    return array;
}

-(void)updateCrystalSummoned:(Crystal *)crystal {
    for (NSObject<EffectSoul>* effect in self.effects) {
        [effect updateCrystalSummoned:crystal];
    }
}

-(void)updateCrystalDied:(Crystal *)crystal {
    for (NSObject<EffectSoul>* effect in self.effects) {
        [effect updateCrystalDied:crystal];
    }
}

@end
