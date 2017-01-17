//
//  SocketHandler.h
//  SoulsGame
//
//  Created by Andrew Cummings on 1/12/17.
//  Copyright © 2017 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetDelegate <NSObject>

-(void)castSpellAtAwayPlayer:(NSInteger)target fromAwayPlayer:(NSInteger)caster andID:(NSString *)spellID;
-(void)castSpellAtHomePlayer:(NSInteger)target fromAwayPlayer:(NSInteger)caster andID:(NSString *)spellID;
-(void)addSoulAtPosition:(NSInteger)target withID:(NSString *)soulID;
-(void)addCrytsalAtPosition:(NSInteger)target withHealth:(NSInteger)health speed:(NSInteger)speed andShield:(NSInteger)shield;

@end

@interface SocketHandler : NSObject <NSStreamDelegate>

-(void)initNetworkCommunication;
-(void)sendMessage:(NSString*)msg;

+(SocketHandler*)getInstance;

@property(nonatomic, strong) NSObject<NetDelegate>* netDelegate;

@end
