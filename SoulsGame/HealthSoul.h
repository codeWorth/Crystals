//
//  HealthSoul.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "AttributeSoul.h"

@interface HealthSoul : NSObject <AttributeSoul>

-(instancetype)initWithHealth:(NSInteger)health;

@end
