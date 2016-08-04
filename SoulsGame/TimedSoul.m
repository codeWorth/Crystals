//
//  TimedSoul.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/29/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "TimedSoul.h"

@interface TimedSoul ()

@property (nonatomic, strong) NSObject<Soul>* soul;
@property (nonatomic) NSInteger timeLeft;

@end

@implementation TimedSoul

-(instancetype)initWithTime:(NSInteger)time andSoul:(NSObject<Soul> *)soul{
    if (self = [super init]){
        self.timeLeft = time;
        self.soul = soul;
    }
    return self;
}

-(void)update{
    if (self.timeLeft > 0){
        self.timeLeft--;
    }
}

-(BOOL)shouldRemove{
    return self.timeLeft == 0;
}

-(NSObject<Soul>*)getSoul{
    return self.soul;
}

+(NSInteger)cost{
    return SPEC_COST;
}

@end
