//
//  Player.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Player.h"

@interface Player ()

@property (nonatomic, strong) Crystal* _crystal1;
@property (nonatomic, strong) Crystal* _crystal2;
@property (nonatomic, strong) Crystal* _crystal3;
@property (nonatomic, strong) Crystal* _crystal4;
@property (nonatomic, strong) Crystal* _crystal5;

@end

@implementation Player

-(instancetype)init{
    if (self = [super init]){
        self.mana = 0;
        
        self.profileImg = [UIImage imageNamed:@"defaultProfile.png"];
        self.username = [NSString stringWithFormat:@"user%i",arc4random_uniform(100)];
    }
    return self;
}

-(void)nextTurn{
    [self._crystal1 nextTurn];
    [self._crystal2 nextTurn];
    [self._crystal3 nextTurn];
    [self._crystal4 nextTurn];
    [self._crystal5 nextTurn];
    
    if (self.mana < MAX_MANA){
        self.mana += 1;
    }
}

-(void)checkCrystalDeath{
    if (self._crystal1.isDead){
        self._crystal1 = nil;
    } else if (self._crystal2.isDead){
        self._crystal2 = nil;
    } else if (self._crystal3.isDead){
        self._crystal3 = nil;
    } else if (self._crystal4.isDead){
        self._crystal4 = nil;
    } else if (self._crystal5.isDead){
        self._crystal5 = nil;
    }
}

-(NSInteger)minCooldown{
    NSInteger minCooldown = 1;
    
    if ([self._crystal1 realCooldown] < minCooldown && self._crystal1 != nil){
        minCooldown = [self._crystal1 realCooldown];
    }
    if ([self._crystal2 realCooldown] < minCooldown && self._crystal2 != nil){
        minCooldown = [self._crystal1 realCooldown];
    }
    if ([self._crystal3 realCooldown] < minCooldown && self._crystal3 != nil){
        minCooldown = [self._crystal3 realCooldown];
    }
    if ([self._crystal4 realCooldown] < minCooldown && self._crystal4 != nil){
        minCooldown = [self._crystal4 realCooldown];
    }
    if ([self._crystal5 realCooldown] < minCooldown && self._crystal5 != nil){
        minCooldown = [self._crystal5 realCooldown];
    }
    return minCooldown;
}

-(Crystal*)crystal1 {
    return self._crystal1;
}

-(Crystal*)crystal2 {
    return self._crystal2;
}

-(Crystal*)crystal3 {
    return self._crystal3;
}

-(Crystal*)crystal4 {
    return self._crystal4;
}

-(Crystal*)crystal5 {
    return self._crystal5;
}

-(Crystal*)crystalN:(NSInteger)n{
    if (n == 1) {
        return self._crystal1;
    } else if (n == 2) {
        return self._crystal2;
    } else if (n == 3) {
        return self._crystal3;
    } else if (n == 4) {
        return self._crystal4;
    } else if (n == 5) {
        return self._crystal5;
    }
    
    return nil;
}

-(void)setCrystal1:(Crystal *)crystal {
    self._crystal1 = crystal;
    self._crystal1.parent = self;
    
    [self.delegate registerAddCrystal:crystal atIndex:1];
}

-(void)setCrystal2:(Crystal *)crystal {
    self._crystal2 = crystal;
    self._crystal2.parent = self;
    
    [self.delegate registerAddCrystal:crystal atIndex:2];
}

-(void)setCrystal3:(Crystal *)crystal {
    self._crystal3 = crystal;
    self._crystal3.parent = self;
    
    [self.delegate registerAddCrystal:crystal atIndex:3];
}

-(void)setCrystal4:(Crystal *)crystal {
    self._crystal4 = crystal;
    self._crystal4.parent = self;
    
    [self.delegate registerAddCrystal:crystal atIndex:4];
}

-(void)setCrystal5:(Crystal *)crystal {
    self._crystal5 = crystal;
    self._crystal5.parent = self;
    
    [self.delegate registerAddCrystal:crystal atIndex:5];
}

-(void)setCrystalN:(NSInteger)n toCrystal:(Crystal *)crystal{
    if (n == 1) {
        [self setCrystal1:crystal];
    } else if (n == 2) {
        [self setCrystal2:crystal];
    } else if (n == 3) {
        [self setCrystal3:crystal];
    } else if (n == 4) {
        [self setCrystal4:crystal];
    } else if (n == 5) {
        [self setCrystal5:crystal];
    }
}

-(void)spellCast:(NSObject<Spell> *)spell fromSource:(Crystal *)source toTarget:(Crystal *)target {
    NSInteger sourceIndex;
    
    if (source == self._crystal1){
        sourceIndex = 1;
    } else if (source == self._crystal2){
        sourceIndex = 2;
    } else if (source == self._crystal3){
        sourceIndex = 3;
    } else if (source == self._crystal4){
        sourceIndex = 4;
    } else if (source == self._crystal5){
        sourceIndex = 5;
    } else {
        return;
    }
    
    [self.delegate registerCastSpell:spell.ID fromSource:sourceIndex toTarget:target];
    
}

-(void)addedSoul:(NSObject<Soul> *)soul toTarget:(Crystal *)target {
    NSInteger targetIndex;
    
    if (target == self._crystal1){
        targetIndex = 1;
    } else if (target == self._crystal2){
        targetIndex = 2;
    } else if (target == self._crystal3){
        targetIndex = 3;
    } else if (target == self._crystal4){
        targetIndex = 4;
    } else if (target == self._crystal5){
        targetIndex = 5;
    } else {
        return;
    }
    
    [self.delegate registerAddSoul:soul.ID toTarget:targetIndex];
}

@end

