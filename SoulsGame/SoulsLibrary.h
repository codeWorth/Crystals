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

+(NSArray*)buffSouls;
+(NSArray*)specSouls;
+(NSArray*)resistSouls;
 
+(Soul*)soulWithID:(NSString*)ID;

@end


/*
 Last used ID: '016'
 
 How to add a new Soul Type:
 
 1. Create a new class, code it up, so on and so forth (subclass ResistSoul)
 2. Check here for the next ID to use
 3. Add an instance of it to the list in this class's .m
 4. Update the Last used ID entry
*/
