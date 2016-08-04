//
//  SpellSelectionController.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/4/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "SoulSelectionController.h"
#import "SoulAddController.h"
#import "Game.h"
#import "SoulCell.h"

@interface SoulSelectionController ()

@property (nonatomic, strong) NSArray* currentSouls;

@property (weak, nonatomic) IBOutlet UIButton *useSoulButton;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation SoulSelectionController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.useSoulButton.enabled = NO;
    
    if (self.selectedType == Resist){
        self.currentSouls = [Game instance].homeKnownResist;
    } else if (self.selectedType == Buff){
        self.currentSouls = [Game instance].homeKnownBuff;
    } else if (self.selectedType == Specialized){
        self.currentSouls = [Game instance].homeKnownSpec;
    } else {
        self.currentSouls = [[NSArray alloc]init];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.currentSouls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* reuseIdentifier = @"SoulCell";
    
    SoulCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSObject<Soul>* soul = self.currentSouls[indexPath.row];
    [cell setupWithSoul:soul];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    //Disallows editing
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[SoulCell class]]){
        SoulCell* soulCell = (SoulCell*)cell;
        self.selectedSoul = soulCell.soul;
        
        if (self.selectedSoul.cost > [Game instance].homePlayer.mana){
            self.useSoulButton.enabled = NO;
            self.infoLabel.text = @"You don't have enough mana!";
        } else {
            self.useSoulButton.enabled = YES;
            self.infoLabel.text = [NSString stringWithFormat:@"This will cost %i mana.", (int)self.selectedSoul.cost];
        }
    }
}

@end
