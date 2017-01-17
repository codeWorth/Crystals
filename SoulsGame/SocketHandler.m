//
//  SocketHandler.m
//  SoulsGame
//
//  Created by Andrew Cummings on 1/12/17.
//  Copyright © 2017 Andrew Cummings. All rights reserved.
//

#import "SocketHandler.h"
#import "Game.h"

@interface SocketHandler()

@property(nonatomic) BOOL searching;
@property(nonatomic) NSInteger playerID;
@property(nonatomic) NSInteger bufferSize;

@end

@implementation SocketHandler

static SocketHandler* instance;

+(SocketHandler*)getInstance {
    if (!instance) {
        instance = [[SocketHandler alloc] init];
        instance.searching = NO;
        instance.bufferSize = 10;
    }
    return instance;
}

NSInputStream *inputStream;
NSOutputStream *outputStream;

- (void)initNetworkCommunication {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)[Game serverIP], 800, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream open];
    [outputStream open];
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
    switch (streamEvent) {
            
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
            
        case NSStreamEventHasBytesAvailable:
            if (theStream == inputStream) {
                
                uint8_t buffer[self.bufferSize];
                NSInteger len;
                
                while ([inputStream hasBytesAvailable]) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        
                        if (nil != output) {
                            if ([output characterAtIndex:0] == '<') {
                                [self recievedControlMessage:output];
                            } else if ([output characterAtIndex:0] == '>') {
                                [self recievedGameMessage:output];
                                [self sendMessage:@"<p"];
                            } else {
                                [self recievedQueueMessage:output];
                                [self sendMessage:@"<p"];
                                
                            }
                        }
                    }
                }
            }
            break;
            
        case NSStreamEventErrorOccurred:
            NSLog(@"Can not connect to the host!");
            break;
        case NSStreamEventEndEncountered:
            break;
            
    }
    
}

-(void)recievedQueueMessage:(NSString*)message {
    char firstChar = [message characterAtIndex:0];
    if (firstChar == 'j') {
        if (self.searching) {
            [self sendMessage:[NSString stringWithFormat:@"^a%ld", self.playerID]];
            [self.queueDelegate queryAccepted];
        } else {
            [self cancelQuery];
        }
    } else if (firstChar == 'r') {
        [self.queueDelegate matchRejected];
    } else if (firstChar == 'c') {
        NSInteger ID = [[message substringFromIndex:2] integerValue];
        [self.queueDelegate matchAcceptedWithID:ID];
    }
}

-(void)recievedGameMessage:(NSString*)message {
    char secondChar = [message characterAtIndex:1];
    if (secondChar == 'c') {
        NSInteger position = [[message substringWithRange:NSMakeRange(2, 1)] integerValue];
        NSInteger health = [self hexToInt:[message substringWithRange:NSMakeRange(3, 1)]];
        NSInteger shields = [self hexToInt:[message substringWithRange:NSMakeRange(4, 1)]];
        NSInteger speed = [self hexToInt:[message substringWithRange:NSMakeRange(5, 1)]];
        [self.gameDelegate addCrytsalAtPosition:position withHealth:health speed:speed andShield:shields];
    } else if (secondChar == 's') {
        NSInteger position = [[message substringWithRange:NSMakeRange(2, 1)] integerValue];
        NSString* id = [message substringFromIndex:3];
        [self.gameDelegate addSoulAtPosition:position withID:id];
    } else if (secondChar == 'h') {
        NSInteger sourcePos = [[message substringWithRange:NSMakeRange(2, 1)] integerValue];
        NSInteger targetPos = [[message substringWithRange:NSMakeRange(3, 1)] integerValue];
        NSString* id = [message substringFromIndex:4];
        [self.gameDelegate castSpellAtHomePlayer:targetPos fromAwayPlayer:sourcePos andID:id];
    } else if (secondChar == 'a') {
        NSInteger sourcePos = [[message substringWithRange:NSMakeRange(2, 1)] integerValue];
        NSInteger targetPos = [[message substringWithRange:NSMakeRange(3, 1)] integerValue];
        NSString* id = [message substringFromIndex:4];
        [self.gameDelegate castSpellAtAwayPlayer:targetPos fromAwayPlayer:sourcePos andID:id];
    }
}

- (void)recievedControlMessage:(NSString*)message {
    if ([message characterAtIndex:1] == 's') {
        [[Game instance] awayEndTurn];
        [self sendMessage:@"<p"];
    } else if ([message characterAtIndex:1] == 'q') {
        [Game instance].homeWonGame = YES;
        [[Game instance] endGame];
    }
}

-(void)sendMessage:(NSString*)msg {
    NSData *data = [[NSData alloc] initWithData:[msg dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
}

-(NSInteger)hexToInt:(NSString *)hex {
    unsigned int outVal;
    NSScanner* scanner = [NSScanner scannerWithString:hex];
    [scanner scanHexInt:&outVal];
    return outVal;
}

-(void)cancelQuery {
    self.searching = NO;
    [self sendMessage:@"^c"];
}

-(void)addToQueueWithRank:(NSInteger)rank andID:(NSInteger)ID {
    NSString* msg = [NSString stringWithFormat:@"^n%ld", (long)rank];
    self.searching = YES;
    self.playerID = ID;
    [self sendMessage:msg];
}

-(void) endGame{
    [self sendMessage:@"<q"];
    [[Game instance] endGame];
}

@end
