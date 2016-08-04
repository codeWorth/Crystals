//
//  Player.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Minion.h"

#define MAX_MANA 25

@interface Player : NSObject

@property (nonatomic) NSInteger mana;
@property (nonatomic, strong) UIImage* profileImg;
@property (nonatomic, strong) NSString* username;

@property (nonatomic, strong) Minion* minion1;
@property (nonatomic, strong) Minion* minion2;
@property (nonatomic, strong) Minion* minion3;
@property (nonatomic, strong) Minion* minion4;
@property (nonatomic, strong) Minion* minion5;

-(void)update;
-(void)nextTurn;
-(NSInteger)minCooldown;

@end
