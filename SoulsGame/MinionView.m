//
//  MinionView.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/29/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "MinionView.h"
#import "Game.h"
#import "Player.h"
#import "BattlefieldController.h"

@interface MinionView ()

@property (nonatomic, weak) IBOutlet UIImageView* backgroundImg;
@property (nonatomic, weak) IBOutlet UIImageView* minionImg;
@property (nonatomic, weak) IBOutlet UILabel* shieldLabel;
@property (nonatomic, weak) IBOutlet UILabel* healthLabel;
@property (nonatomic, weak) IBOutlet UILabel* speedLabel;

@end

@implementation MinionView

-(void)updateWithMinion:(Minion*)minion{
    if (minion == nil){
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    	
    self.shieldLabel.text = @([minion shield]).stringValue;
    self.healthLabel.text = @([minion health]).stringValue;
    self.speedLabel.text = @([minion cooldown]).stringValue;
    
    self.minionImg.image = [minion imgDesc];
}

@end
