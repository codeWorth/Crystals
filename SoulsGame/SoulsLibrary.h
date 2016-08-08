//
//  SoulsLibrary.h
//  SoulsGame
//
//  Created by Andrew Cummings on 8/7/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Soul.h"

@interface SoulsLibrary : NSObject

+(NSArray*)souls;

+(NSObject<Soul>*)soulWithID:(NSString*)ID;

@end
