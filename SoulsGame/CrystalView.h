//
//  CrystalView.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/29/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Crystal.h"
@class BattlefieldController;

@interface CrystalView : UIButton

-(void)updateWithCrystal:(Crystal*)crystal;

@end
