//
//  MinionView.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/29/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Minion.h"
@class BattlefieldController;

@interface MinionView : UIButton

-(void)updateWithMinion:(Minion*)minion;

@end
