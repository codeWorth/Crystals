//
//  SoulsLibrary.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/7/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "SoulsLibrary.h"

#import "FireResist.h"
#import "WaterResist.h"
#import "LifeBuff.h"
#import "FireBuff.h"
#import "WaterBuff.h"
#import "EarthResist.h"
#import "AirResist.h"
#import "SunResist.h"
#import "LifeResist.h"
#import "MoonResist.h"
#import "ShadowResist.h"
#import "EarthBuff.h"
#import "AirBuff.h"
#import "SunBuff.h"
#import "MoonBuff.h"
#import "ShadowBuff.h"

@interface SoulsLibrary ()

@property (nonatomic, strong) NSArray* buffSouls;
@property (nonatomic, strong) NSArray* resistSouls;
@property (nonatomic, strong) NSArray* specSouls;

@end

@implementation SoulsLibrary

static SoulsLibrary* soulsInstance = nil;

-(instancetype)init{
    if (self = [super init]){
        
        NSMutableArray *addSouls = [[NSMutableArray alloc]init];
        
        [addSouls addObject:[[FireResist alloc]init]];
        [addSouls addObject:[[WaterResist alloc]init]];
        [addSouls addObject:[[EarthResist alloc]init]];
        [addSouls addObject:[[AirResist alloc]init]];
        [addSouls addObject:[[SunResist alloc]init]];
        [addSouls addObject:[[MoonResist alloc]init]];
        [addSouls addObject:[[ShadowResist alloc]init]];
        [addSouls addObject:[[LifeResist alloc]init]];
        
        self.resistSouls = [addSouls copy];
        [addSouls removeAllObjects];
        
        [addSouls addObject:[[LifeBuff alloc]init]];
        [addSouls addObject:[[FireBuff alloc]init]];
        [addSouls addObject:[[WaterBuff alloc]init]];
        [addSouls addObject:[[EarthBuff alloc]init]];
        [addSouls addObject:[[SunBuff alloc]init]];
        [addSouls addObject:[[AirBuff alloc]init]];
        [addSouls addObject:[[MoonBuff alloc]init]];
        [addSouls addObject:[[ShadowBuff alloc]init]];
        
        self.buffSouls = [addSouls copy];
        [addSouls removeAllObjects];
        
        
        self.specSouls = [addSouls copy];
    }
    return self;
}

+(NSArray*)resistSouls {
    if (soulsInstance == nil){
        soulsInstance = [[SoulsLibrary alloc]init];
    }
    return soulsInstance.resistSouls;
}

+(NSArray*)buffSouls {
    if (soulsInstance == nil){
        soulsInstance = [[SoulsLibrary alloc]init];
    }
    return soulsInstance.buffSouls;
}

+(NSArray*)specSouls {
    if (soulsInstance == nil){
        soulsInstance = [[SoulsLibrary alloc]init];
    }
    return soulsInstance.specSouls;
}

+(Soul*)soulWithID:(NSString*)ID{
    if (soulsInstance == nil){
        soulsInstance = [[SoulsLibrary alloc]init];
    }
    
    for (Soul* soul in soulsInstance.resistSouls){
        if ([soul.ID isEqualToString:ID]){
            return [soul copy];
        }
    }
    
    for (Soul* soul in soulsInstance.buffSouls){
        if ([soul.ID isEqualToString:ID]){
            return [soul copy];
        }
    }
    
    for (Soul* soul in soulsInstance.specSouls){
        if ([soul.ID isEqualToString:ID]){
            return [soul copy];
        }
    }
    
    return nil;
}

@end
