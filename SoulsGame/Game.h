//
//  Game.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Crystal.h"

@protocol UpdateableController <NSObject>

-(void)updateGUI;
@property (nonatomic) NSInteger userID;
@property (nonatomic) NSInteger awayID;

@end

@class Crystal;

@interface Game : NSObject <NetComm>

@property (nonatomic) NSInteger time;

@property (nonatomic, strong) Player* homePlayer;
@property (nonatomic, strong) Player* awayPlayer;

@property (nonatomic, strong) NSArray* homeKnownResist;
@property (nonatomic, strong) NSArray* homeKnownBuff;
@property (nonatomic, strong) NSArray* homeKnownSpec;

@property (nonatomic, strong) NSArray* knownSpells;

@property (nonatomic) BOOL canAttack;

-(void)checkCrystalDeath;

-(void)homeEndTurn;
-(void)awayEndTurn;

+(Game*)instance;
-(void)setDelegate:(UIViewController<UpdateableController> *)delegate;

+(NSInteger)crystalCreateCost;

-(void)queryGUIUpdate;
-(void)setShouldStart;

@end
