//
//  CrystalView.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/29/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "CrystalView.h"
#import "Game.h"
#import "Player.h"
#import "BattlefieldController.h"

@interface CrystalView ()

@property (nonatomic, weak) IBOutlet UIImageView* backgroundImg;
@property (nonatomic, weak) IBOutlet UIImageView* crystalImg;
@property (nonatomic, weak) IBOutlet UILabel* shieldLabel;
@property (nonatomic, weak) IBOutlet UILabel* healthLabel;
@property (nonatomic, weak) IBOutlet UILabel* speedLabel;

@end

@implementation CrystalView

-(void)updateWithCrystal:(Crystal*)crystal{
    if (crystal == nil){
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    	
    self.shieldLabel.text = @([crystal shield]).stringValue;
    self.healthLabel.text = @([crystal health]).stringValue;
    self.speedLabel.text = @([crystal cooldown]).stringValue;
    
    self.crystalImg.image = [crystal imgDesc];
}

@end
