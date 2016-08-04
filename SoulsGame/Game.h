//
//  Game.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@class Minion;

@interface Game : NSObject

@property (nonatomic) NSInteger time;

@property (nonatomic, strong) Player* homePlayer;
@property (nonatomic, strong) Player* awayPlayer;

@property (nonatomic, strong) NSArray* homeKnownResist;
@property (nonatomic, strong) NSArray* homeKnownBuff;
@property (nonatomic, strong) NSArray* homeKnownSpec;

@property (nonatomic, strong) NSArray* knownSpells;

@property (nonatomic) BOOL canAttack;

-(void)update;

-(void)homeEndTurn;
-(void)awayEndTurn;

+(Game*)instance;

+(NSInteger)minionCreateCost;

@end
