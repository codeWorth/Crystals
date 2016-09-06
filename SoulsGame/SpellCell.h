//
//  SpellCell.h
//  SoulsGame
//
//  Created by Andrew Cummings on 6/6/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Spell.h"

@interface SpellCell : UITableViewCell

@property (nonatomic, strong) Spell* spell;

-(void)updateWith:(Spell*)spell;

@end
