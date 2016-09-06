//
//  ViewController.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "Spell.h"

@interface BattlefieldController : UIViewController <UpdateableController>

@property (nonatomic) NSInteger userID;
@property (nonatomic) NSInteger awayID;
@property (nonatomic) NSString* username;

-(void)updateGUI;
-(void)exitSegue;

@end

