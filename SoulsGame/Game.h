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
#import "SocketHandler.h"

@protocol UpdateableController <NSObject>

-(void)updateGUI;
-(void)exitSegue;
@property (nonatomic) NSInteger userID;
@property (nonatomic) NSInteger awayID;

@end

@class Crystal;

@interface Game : NSObject <NetComm, NetDelegate>

@property (nonatomic) NSInteger time;

@property (nonatomic, strong) Player* homePlayer;
@property (nonatomic, strong) Player* awayPlayer;

@property (nonatomic, strong) NSArray* homeKnownResist;
@property (nonatomic, strong) NSArray* homeKnownBuff;
@property (nonatomic, strong) NSArray* homeKnownSpec;

@property (nonatomic, strong) NSArray* knownSpells;

@property (nonatomic) BOOL canAttack;

-(BOOL)checkCrystalDeath;

-(void)homeEndTurn;
-(void)awayEndTurn;
-(void)endGame;

+(Game*)instance;
-(void)setDelegate:(UIViewController<UpdateableController> *)delegate;

+(NSInteger)crystalCreateCost;
+(NSString*)serverIP;

-(void)setShouldStart;

@property (nonatomic) BOOL offline;

@end
