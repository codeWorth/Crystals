//
//  TimedSoul.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/29/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Soul.h"

@interface TimedSoul : NSObject
-(instancetype)initWithTime:(NSInteger)time andSoul:(NSObject<Soul>*)soul;
-(void)update;

-(NSObject<Soul>*)getSoul;
-(BOOL)shouldRemove;

@end
