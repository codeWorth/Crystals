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

@class Crystal;

@interface Spell : NSObject

@property (nonatomic) enum ElementType type;
@property (nonatomic) NSInteger cost;
@property (nonatomic) BOOL positiveEffect;
@property (nonatomic) NSString *ID;

@property (nonatomic, strong) NSString* desc;
@property (nonatomic, strong) NSString* flavorText;
@property (nonatomic, strong) UIImage* img;
@property (nonatomic, strong) NSString* name;
@property (nonatomic) BOOL canTargetEnemies;
@property (nonatomic) BOOL canTargetFriendlies;

-(NSInteger)amount;
-(void)setAmount:(NSInteger)amount;

-(NSArray*)targetsForCrystal:(Crystal*)crystal;

-(NSMutableArray*)affectCrystal:(Crystal*)crystal; //returns the effects that should be put on the crystal

@end
