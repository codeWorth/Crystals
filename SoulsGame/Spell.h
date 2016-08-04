//
//  Spell.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ElementType.m"
#import <UIKit/UIKit.h>

@class Minion;

@protocol Spell <NSObject>

@property (nonatomic) enum ElementType type;
@property (nonatomic) NSInteger cost;
@property (nonatomic) BOOL positiveEffect;

@property (nonatomic, strong) NSString* desc;
@property (nonatomic, strong) NSString* flavorText;
@property (nonatomic, strong) UIImage* img;
@property (nonatomic, strong) NSString* name;
@property (nonatomic) BOOL canTargetEnemies;
@property (nonatomic) BOOL canTargetFriendlies;

-(NSInteger)amount;
-(void)setAmount:(NSInteger)newAmount;

-(NSMutableArray*)affectMinion:(Minion*)minion; //returns the effects that should be put on the minion

@end
