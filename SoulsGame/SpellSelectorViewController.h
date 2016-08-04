//
//  SpellSelector.h
//  SoulsGame
//
//  Created by Andrew Cummings on 6/6/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Minion;
@protocol Spell;

@interface SpellSelectorViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) NSObject<Spell>* selectedSpell;
@property (strong, nonatomic) Minion* sourceMinion;

@end
