//
//  SpellSelectionController.h
//  SoulsGame
//
//  Created by Andrew Cummings on 7/4/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Soul.h"
#import "SoulType.m"

@interface SoulSelectionController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSObject<Soul>* selectedSoul;

@property (nonatomic) SoulType selectedType;

@end
