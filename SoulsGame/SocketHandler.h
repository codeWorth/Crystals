//
//  SocketHandler.h
//  SoulsGame
//
//  Created by Andrew Cummings on 1/12/17.
//  Copyright © 2017 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocketHandler : NSObject <NSStreamDelegate>

-(void)initNetworkCommunication;
-(void)sendMessage:(NSString*)msg;

+(SocketHandler*)getInstance;

@end
