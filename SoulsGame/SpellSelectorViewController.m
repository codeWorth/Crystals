//
//  SpellSelector.m
//  SoulsGame
//
//  Created by Andrew Cummings on 6/6/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "SpellSelectorViewController.h"
#import "Spell.h"
#import "SpellCell.h"
#import "Fireball.h"
#import "QuickHeal.h"
#import "BattlefieldController.h"

@interface SpellSelectorViewController ()

@property (strong, nonatomic) NSArray* spells;

@property (weak, nonatomic) IBOutlet UIView *spellDetailView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *spellImgView;
@property (weak, nonatomic) IBOutlet UITextView *spellDesc;
@property (weak, nonatomic) IBOutlet UITextView *flavorText;

@property (weak, nonatomic) IBOutlet UITextView *effectList1;
@property (weak, nonatomic) IBOutlet UITextView *effectList2;
@property (weak, nonatomic) IBOutlet UITextView *effectList3;

@property (weak, nonatomic) IBOutlet UILabel *initialLabel;

@property (weak, nonatomic) IBOutlet UIButton *castButton;

@end

@implementation SpellSelectorViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.spells = [Game instance].knownSpells;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.spellDetailView.hidden = YES;
    self.initialLabel.hidden = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Spells";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.spells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* reuseIdentifier = @"spellCell";
    
    SpellCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSObject<Spell>* spell = self.spells[indexPath.row];
    [cell updateWith:spell];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    //Disallows editing
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[SpellCell class]]){
        SpellCell* spellCell = (SpellCell*)cell;
        NSObject<Spell>* spell = spellCell.spell;
        
        self.nameLabel.text = spell.name;
        self.spellImgView.image = spell.img;
        
        
        self.spellDetailView.hidden = NO;
        self.initialLabel.hidden = YES;
        
        if (spell.cost > [Game instance].homePlayer.mana){
            self.castButton.enabled = NO;
            
            self.spellDesc.text = @"Not enough mana";
            
            self.flavorText.text = @"";
            
            self.effectList1.text = @"";
            self.effectList2.text = @"";
            self.effectList3.text = @"";
        } else {
            self.castButton.enabled = YES;
            
            self.spellDesc.text = spell.desc;
            self.flavorText.text = spell.flavorText;
            
            NSArray* effects = [self.sourceMinion effectsOnSpell:spell];
            if (effects.count == 0){
                self.effectList1.text = @"This minion has no effect on this spell";
                self.effectList2.text = @"";
                self.effectList3.text = @"";
            } else {
                self.effectList1.text = @"";
                self.effectList2.text = @"";
                self.effectList3.text = @"";
                
                int box = 0;
                for (NSString* effect in effects) {
                    if (box == 0){
                        self.effectList1.text = [NSString stringWithFormat:@"%@-%@\n", self.effectList1.text, effect];
                    } else if (box == 1){
                        self.effectList2.text = [NSString stringWithFormat:@"%@-%@\n", self.effectList2.text, effect];
                    } else {
                        self.effectList3.text = [NSString stringWithFormat:@"%@-%@\n", self.effectList3.text, effect];
                    }
                    
                    box++;
                    if (box > 2){
                        box = 0;
                    }
                }
            }
            
            self.selectedSpell = spell;
        }
        
        
    }
}


@end
