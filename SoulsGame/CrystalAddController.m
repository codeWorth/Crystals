//
//  CrystalAddController.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/7/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "CrystalAddController.h"
#import "StatMeter.h"
#import "Game.h"
#import "Player.h"

@interface CrystalAddController ()

@property (weak, nonatomic) IBOutlet StatMeter *healthMeter;
@property (weak, nonatomic) IBOutlet StatMeter *shieldMeter;
@property (weak, nonatomic) IBOutlet StatMeter *speedMeter;

@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (nonatomic) NSInteger points;

@property (weak, nonatomic) IBOutlet UILabel *pageTitle;

@property (weak, nonatomic) IBOutlet UIButton *createButton;

@end

#define TICK_SPACING 2
#define MAX_POINTS 12

@implementation CrystalAddController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.points = MAX_POINTS;
    
    self.currentHealth = 0;
    self.currentShield = 0;
    self.currentSpeed = 0;
    
    self.healthMeter.tickSpacing = TICK_SPACING;
    self.healthMeter.maxTicks = MAX_POINTS;
    self.healthMeter.color = [UIColor colorWithRed:0.7 green:0.2 blue:0.2 alpha:0.7];
    
    self.shieldMeter.tickSpacing = TICK_SPACING;
    self.shieldMeter.maxTicks = MAX_POINTS;
    self.shieldMeter.color = [UIColor colorWithRed:0.2 green:0.2 blue:0.7 alpha:0.7];
    
    self.speedMeter.tickSpacing = TICK_SPACING;
    self.speedMeter.maxTicks = MAX_POINTS;
    self.speedMeter.color = [UIColor colorWithRed:0.9 green:0.7 blue:0.2 alpha:0.7];
    
    [self update];
}

- (IBAction)healthDown {
    if (self.currentHealth > 0){
        self.points++;
        self.currentHealth--;
    }
    [self update];
}

- (IBAction)healthUp {
    if (self.currentHealth < MAX_POINTS && self.points > 0){
        self.points--;
        self.currentHealth++;
    }
    [self update];
}

- (IBAction)shieldDown {
    if (self.currentShield > 0){
        self.points++;
        self.currentShield--;
    }
    [self update];
}

- (IBAction)shieldUp {
    if (self.currentShield < MAX_POINTS && self.points > 0){
        self.points--;
        self.currentShield++;
    }
    [self update];
}

- (IBAction)speedDown {
    if (self.currentSpeed > 0){
        self.points++;
        self.currentSpeed--;
    }
    [self update];
}

- (IBAction)speedUp {
    if (self.currentSpeed < MAX_POINTS && self.points > 0){
        self.points--;
        self.currentSpeed++;
    }
    [self update];
}

-(void)update{
    self.pointsLabel.text = [NSString stringWithFormat:@"Points Remaining: %i", (int)self.points];
     if ([Game instance].homePlayer.mana < [Game crystalCreateCost]){
        self.createButton.enabled = NO;
        self.pageTitle.text = @"Not enough mana!";
     } else if (self.points != 0){
         self.createButton.enabled = NO;
         self.pageTitle.text = @"Create a Crystal";
     } else if (self.currentHealth == 0){
        self.createButton.enabled = NO;
        self.pageTitle.text = @"Too little health!";
    } else {
        self.createButton.enabled = YES;
        self.pageTitle.text = @"Create a Crystal";
    }
    
    
    self.healthMeter.amount = self.currentHealth;
    [self.healthMeter setNeedsDisplay];
    
    self.shieldMeter.amount = self.currentShield;
    [self.shieldMeter setNeedsDisplay];
    
    self.speedMeter.amount = self.currentSpeed;
    [self.speedMeter setNeedsDisplay];
}

@end
