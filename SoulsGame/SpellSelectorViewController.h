//
//  SpellSelector.h
//  SoulsGame
//
//  Created by Andrew Cummings on 6/6/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Crystal;
@class Spell;

@interface SpellSelectorViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) Spell* selectedSpell;
@property (strong, nonatomic) Crystal* sourceCrystal;

@end
