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

@interface SoulsLibrary ()

@property (nonatomic, strong) NSArray* souls;

@end

@implementation SoulsLibrary

static SoulsLibrary* soulsInstance = nil;

-(instancetype)init{
    if (self = [super init]){
        
        NSMutableArray *addSouls = [[NSMutableArray alloc]init];
        
        [addSouls addObject:[[FireResist alloc]init]];
        [addSouls addObject:[[WaterResist alloc]init]];
        [addSouls addObject:[[LifeBuff alloc]init]];
        [addSouls addObject:[[FireBuff alloc]init]];
        [addSouls addObject:[[WaterBuff alloc]init]];
        
        self.souls = [addSouls copy];
        
    }
    return self;
}

+(NSArray*)souls{
    if (soulsInstance == nil){
        soulsInstance = [[SoulsLibrary alloc]init];
    }
    return soulsInstance.souls;
}

+(NSObject<Soul>*)soulWithID:(NSString*)ID{
    if (soulsInstance == nil){
        soulsInstance = [[SoulsLibrary alloc]init];
    }
    
    for (NSObject<Soul>* soul in soulsInstance.souls){
        if ([soul.ID isEqualToString:ID]){
            return [soul copy];
        }
    }
    
    return nil;
}

@end
