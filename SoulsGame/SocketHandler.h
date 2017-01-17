//
//  SocketHandler.h
//  SoulsGame
//
//  Created by Andrew Cummings on 1/12/17.
//  Copyright © 2017 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameDelegate <NSObject>

-(void)castSpellAtAwayPlayer:(NSInteger)target fromAwayPlayer:(NSInteger)caster andID:(NSString *)spellID;
-(void)castSpellAtHomePlayer:(NSInteger)target fromAwayPlayer:(NSInteger)caster andID:(NSString *)spellID;
-(void)addSoulAtPosition:(NSInteger)target withID:(NSString *)soulID;
-(void)addCrytsalAtPosition:(NSInteger)target withHealth:(NSInteger)health speed:(NSInteger)speed andShield:(NSInteger)shield;

@end

@protocol QueueDelegate <NSObject>

-(void)queryAccepted;
-(void)matchAccepted;
-(void)matchRejected;

@end

@interface SocketHandler : NSObject <NSStreamDelegate>

-(void)initNetworkCommunication;
-(void)sendMessage:(NSString*)msg;

-(void)addToQueueWithUsername:(NSString *)name andRank:(NSInteger)rank;
-(void)cancelQuery;

+(SocketHandler*)getInstance;

@property(nonatomic, strong) NSObject<GameDelegate>* gameDelegate;
@property(nonatomic, strong) NSObject<QueueDelegate>* queueDelegate;

@end
