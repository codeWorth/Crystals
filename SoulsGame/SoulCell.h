//
//  SoulCell.h
//  SoulsGame
//
//  Created by Andrew Cummings on 7/4/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Soul.h"

@interface SoulCell : UITableViewCell

-(void)setupWithSoul:(Soul*)soul;
@property (nonatomic, strong) Soul* soul;

@end
