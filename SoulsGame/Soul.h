//
//  Soul.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define MINOR_BUFF_AMOUNT 1
#define MAJOR_BUFF_AMOUNT 2	

#define RESIST_COST 4;
#define BUFF_COST 6;
#define SPEC_COST 9;

@protocol Soul <NSObject>

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) UIImage* img;
@property (nonatomic, strong) NSString* desc;
@property (nonatomic, strong) NSString* ID;

-(void)applyMinorBuff;
-(void)applyMajorBuff;

@property (nonatomic) BOOL minorBuffApplied;
@property (nonatomic) BOOL majorBuffApplied;

-(NSInteger)cost;

@end
