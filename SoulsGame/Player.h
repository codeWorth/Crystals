//
//  Player.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Crystal.h"
#import "EffectSoul.h"

#define MAX_MANA 25

@protocol NetComm <NSObject>

-(void)registerCastSpell:(NSString*)spellID fromSource:(NSInteger)source toTarget:(Crystal*)target;
-(void)registerAddCrystal:(Crystal*)crystal atIndex:(NSInteger)index;
-(void)registerAddSoul:(NSString*)soulID toTarget:(NSInteger)target;

@property (nonatomic) NSInteger messageIndex;
@property (nonatomic, strong) NSMutableString* currentBuffer;

@end

@interface Player : NSObject

@property (nonatomic) NSInteger mana;
@property (nonatomic, strong) UIImage* profileImg;
@property (nonatomic, strong) NSString* username;

@property (nonatomic, strong) NSMutableArray* effects;

@property (nonatomic, strong) NSObject<NetComm>* delegate;

-(Crystal*)crystal1;
-(Crystal*)crystal2;
-(Crystal*)crystal3;
-(Crystal*)crystal4;
-(Crystal*)crystal5;
-(Crystal*)crystalN:(NSInteger)n;
-(NSArray*)crystals;

-(void)setCrystal1:(Crystal*)crystal;
-(void)setCrystal2:(Crystal*)crystal;
-(void)setCrystal3:(Crystal*)crystal;
-(void)setCrystal4:(Crystal*)crystal;
-(void)setCrystal5:(Crystal*)crystal;
-(void)setCrystalN:(NSInteger)n toCrystal:(Crystal*)crystal;

-(BOOL)checkCrystalDeath;
-(void)nextTurn;
-(NSInteger)minCooldown;

-(void)spellCast:(Spell*)spell fromSource:(Crystal*)source toTarget:(Crystal*)target;
-(void)addedSoul:(Soul*)soul toTarget:(Crystal*)target;

@end
