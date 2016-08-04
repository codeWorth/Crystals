//
//  ViewController.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "BattlefieldController.h"
#import "Game.h"
#import "MinionView.h"
#import "SpellSelectorViewController.h"
#import "SoulAddController.h"
#import "MinionAddController.h"
#import "TransparentCover.h"

#define MINION_H1_TAG 1
#define MINION_H2_TAG 2
#define MINION_H3_TAG 3
#define MINION_H4_TAG 4
#define MINION_H5_TAG 5
#define MINION_A1_TAG 6
#define MINION_A2_TAG 7
#define MINION_A3_TAG 8
#define MINION_A4_TAG 9
#define MINION_A5_TAG 10

@interface BattlefieldController ()

@property (nonatomic, weak) IBOutlet UILabel* timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextTurnButton;

@property (nonatomic, weak) IBOutlet MinionView* minionH1;
@property (nonatomic, weak) IBOutlet MinionView* minionH2;
@property (nonatomic, weak) IBOutlet MinionView* minionH3;
@property (nonatomic, weak) IBOutlet MinionView* minionH4;
@property (nonatomic, weak) IBOutlet MinionView* minionH5;

@property (nonatomic, weak) IBOutlet MinionView* minionA1;
@property (nonatomic, weak) IBOutlet MinionView* minionA2;
@property (nonatomic, weak) IBOutlet MinionView* minionA3;
@property (nonatomic, weak) IBOutlet MinionView* minionA4;
@property (nonatomic, weak) IBOutlet MinionView* minionA5;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *AwayHighlights;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *HomeHighlights;

@property (weak, nonatomic) IBOutlet UIButton *minionAdd1;
@property (weak, nonatomic) IBOutlet UIButton *minionAdd2;
@property (weak, nonatomic) IBOutlet UIButton *minionAdd3;
@property (weak, nonatomic) IBOutlet UIButton *minionAdd4;
@property (weak, nonatomic) IBOutlet UIButton *minionAdd5;
@property (weak, nonatomic) IBOutlet TransparentCover *minionAddContainer;

@property (nonatomic, weak) IBOutlet UILabel* manaLabel;

@property (nonatomic, weak) IBOutlet UIImageView* homeImg;
@property (nonatomic, weak) IBOutlet UILabel* homeName;

@property (nonatomic, weak) IBOutlet UIImageView* awayImg;
@property (nonatomic, weak) IBOutlet UILabel* awayName;

@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIView *homeHighlightsView;
@property (weak, nonatomic) IBOutlet UIView *awayHighlightsView;

@property (nonatomic, strong) NSObject<Spell>* selectedSpell;
@property (nonatomic) BOOL shouldSelectSpellTarget;

@property (nonatomic) BOOL shouldAddSoul;

@property (nonatomic, strong) Game* game;
@property (nonatomic, strong) Minion* selectedMinion;
@property (nonatomic) NSInteger selectedTag;

@end

@implementation BattlefieldController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSComparator compareTags = ^(id a, id b) {
        NSInteger aTag = [b tag];
        NSInteger bTag = [a tag];
        return aTag < bTag ? NSOrderedDescending
        : aTag > bTag ? NSOrderedAscending
        : NSOrderedSame;
    };
    self.AwayHighlights = [self.AwayHighlights sortedArrayUsingComparator:compareTags];
    self.HomeHighlights = [self.HomeHighlights sortedArrayUsingComparator:compareTags];
    
    [self hideAllHighlights];
    
    self.game = [Game instance];
    
    [self coverReset];
    
    self.minionH1.tag = MINION_H1_TAG;
    self.minionH2.tag = MINION_H2_TAG;
    self.minionH3.tag = MINION_H3_TAG;
    self.minionH4.tag = MINION_H4_TAG;
    self.minionH5.tag = MINION_H5_TAG;
    
    self.minionA1.tag = MINION_A1_TAG;
    self.minionA2.tag = MINION_A2_TAG;
    self.minionA3.tag = MINION_A3_TAG;
    self.minionA4.tag = MINION_A4_TAG;
    self.minionA5.tag = MINION_A5_TAG;
    
    self.minionAdd1.tag = MINION_H1_TAG;
    self.minionAdd2.tag = MINION_H2_TAG;
    self.minionAdd3.tag = MINION_H3_TAG;
    self.minionAdd4.tag = MINION_H4_TAG;
    self.minionAdd5.tag = MINION_H5_TAG;
    
    [self updateGUI];
}

-(Minion*)minionForTag:(NSInteger)tag{
    if (tag == MINION_H1_TAG){
        return self.game.homePlayer.minion1;
    } else if (tag == MINION_H2_TAG){
        return self.game.homePlayer.minion2;
    } else if (tag == MINION_H3_TAG){
        return self.game.homePlayer.minion3;
    } else if (tag == MINION_H4_TAG){
        return self.game.homePlayer.minion4;
    } else if (tag == MINION_H5_TAG){
        return self.game.homePlayer.minion5;
    } else if (tag == MINION_A1_TAG){
        return self.game.awayPlayer.minion1;
    } else if (tag == MINION_A2_TAG){
        return self.game.awayPlayer.minion2;
    } else if (tag == MINION_A3_TAG){
        return self.game.awayPlayer.minion3;
    } else if (tag == MINION_A4_TAG){
        return self.game.awayPlayer.minion4;
    } else if (tag == MINION_A5_TAG){
        return self.game.awayPlayer.minion5;
    } else {
        return nil;
    }
}

-(void)setMinion:(Minion*)minion forTag:(NSInteger)tag{
    if (tag == MINION_H1_TAG){
        self.game.homePlayer.minion1 = minion;
    } else if (tag == MINION_H2_TAG){
        self.game.homePlayer.minion2 = minion;
    } else if (tag == MINION_H3_TAG){
        self.game.homePlayer.minion3 = minion;
    } else if (tag == MINION_H4_TAG){
        self.game.homePlayer.minion4 = minion;
    } else if (tag == MINION_H5_TAG){
        self.game.homePlayer.minion5 = minion;
    }
}

-(void)updateGUI{
    [self updateTimeLabel];
    [self updateManaLabel];
    
    [self updateHomeUser];
    [self updateAwayUser];
    
    [self.minionH1 updateWithMinion:self.game.homePlayer.minion1];
    [self.minionH2 updateWithMinion:self.game.homePlayer.minion2];
    [self.minionH3 updateWithMinion:self.game.homePlayer.minion3];
    [self.minionH4 updateWithMinion:self.game.homePlayer.minion4];
    [self.minionH5 updateWithMinion:self.game.homePlayer.minion5];
    
    [self.minionA1 updateWithMinion:self.game.awayPlayer.minion1];
    [self.minionA2 updateWithMinion:self.game.awayPlayer.minion2];
    [self.minionA3 updateWithMinion:self.game.awayPlayer.minion3];
    [self.minionA4 updateWithMinion:self.game.awayPlayer.minion4];
    [self.minionA5 updateWithMinion:self.game.awayPlayer.minion5];
    
    [self hideAllHighlights];
    
    if (self.game.canAttack){
        self.nextTurnButton.enabled = YES;
        [self showHomeHighlights];
    } else {
        self.nextTurnButton.enabled = NO;
    }
}

-(void)update{
    [self.game update];
    [self updateGUI];

}

-(IBAction)nextTurn{
    [self.game homeEndTurn];
    [self updateGUI];
}

-(void)hideAllHighlights{
    for (UIImageView* img in self.AwayHighlights) {
        img.hidden = YES;
    }
    for (UIImageView* img in self.HomeHighlights) {
        img.hidden = YES;
    }
}

-(void)showHomeHighlights{
    if (self.game.homePlayer.minion1 != nil && [self.game.homePlayer.minion1 cooldown] == 0){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:0]).hidden = NO;
    }
    if (self.game.homePlayer.minion2 != nil && [self.game.homePlayer.minion2 cooldown] == 0){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:1]).hidden = NO;
    }
    if (self.game.homePlayer.minion3 != nil && [self.game.homePlayer.minion3 cooldown] == 0){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:2]).hidden = NO;
    }
    if (self.game.homePlayer.minion4 != nil && [self.game.homePlayer.minion4 cooldown] == 0){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:3]).hidden = NO;
    }
    if (self.game.homePlayer.minion5 != nil && [self.game.homePlayer.minion5 cooldown] == 0){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:4]).hidden = NO;
    }
}

-(void)highlightHomeMinions{
    if (self.game.homePlayer.minion1 != nil){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:0]).hidden = NO;
    }
    if (self.game.homePlayer.minion2 != nil){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:1]).hidden = NO;
    }
    if (self.game.homePlayer.minion3 != nil){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:2]).hidden = NO;
    }
    if (self.game.homePlayer.minion4 != nil){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:3]).hidden = NO;
    }
    if (self.game.homePlayer.minion5 != nil){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:4]).hidden = NO;
    }
}

-(void)coverBoth{
    [self.view bringSubviewToFront:self.coverView];
}

-(void)homeMinionsToFront{
    [self.view bringSubviewToFront:self.minionH1];
    [self.view bringSubviewToFront:self.minionH2];
    [self.view bringSubviewToFront:self.minionH3];
    [self.view bringSubviewToFront:self.minionH4];
    [self.view bringSubviewToFront:self.minionH5];
}

-(void)awayMinionsToFront{
    [self.view bringSubviewToFront:self.minionA1];
    [self.view bringSubviewToFront:self.minionA2];
    [self.view bringSubviewToFront:self.minionA3];
    [self.view bringSubviewToFront:self.minionA4];
    [self.view bringSubviewToFront:self.minionA5];
}

-(void)coverFriendly{
    [self.view bringSubviewToFront:self.coverView];
    [self.view bringSubviewToFront:self.awayHighlightsView];
    [self awayMinionsToFront];
}

-(void)coverEnemy{
    [self.view bringSubviewToFront:self.coverView];
    [self.view bringSubviewToFront:self.homeHighlightsView];
    [self homeMinionsToFront];
}

-(void)coverNeither{
    [self.view bringSubviewToFront:self.homeHighlightsView];
    [self homeMinionsToFront];
    [self.view bringSubviewToFront:self.awayHighlightsView];
    [self awayMinionsToFront];
}

-(void)coverReset{
    self.coverView.hidden = YES;
    [self.view bringSubviewToFront:self.homeHighlightsView];
    [self.view bringSubviewToFront:self.minionAddContainer];
    [self homeMinionsToFront];
}

-(void)updateTimeLabel{
    self.timeLabel.text = [NSString stringWithFormat:@"Time: %i",(int)self.game.time];
}

-(void)updateManaLabel{
    self.manaLabel.text = [NSString stringWithFormat:@"Mana: %i",(int)self.game.homePlayer.mana];
}

-(void)updateHomeUser{
    self.homeImg.image = self.game.homePlayer.profileImg;
    self.homeName.text = self.game.homePlayer.username;
}

-(void)updateAwayUser{
    self.awayImg.image = self.game.awayPlayer.profileImg;
    self.awayName.text = self.game.awayPlayer.username;
}

- (IBAction)friendlyMinionSelected:(MinionView *)sender {
    Minion* minion = [self minionForTag:sender.tag];
    
    if (self.shouldSelectSpellTarget) {
        [self castSpellOnMinion:minion];
    } else if (self.game.canAttack) {
        if (self.shouldAddSoul){
            self.shouldAddSoul = NO;
            [self coverReset];
            self.selectedMinion = minion;
            
            [self performSegueWithIdentifier:@"toSoulAdd" sender:self];
        } else {
            if ([minion canCastSpell]){
                self.selectedMinion = minion;
                
                [self performSegueWithIdentifier:@"toSpells" sender:self];
            } else {
                NSLog(@"cant cast rn soz");
            }
        }
    }
}

- (IBAction)enemyMinionSelected:(MinionView *)sender {
    if (self.shouldSelectSpellTarget){
        [self castSpellOnMinion:[self minionForTag:sender.tag]];
    }
}

-(void)castSpellOnMinion:(Minion*)minion{
    [self coverReset];
    self.shouldSelectSpellTarget = NO;
    
    self.game.homePlayer.mana -= self.selectedSpell.cost;
    [self.selectedMinion castSpell:self.selectedSpell onTarget:minion];
    [self update];
}

-(IBAction)segueCastSpell:(UIStoryboardSegue*)segue{
    if ([segue.sourceViewController isKindOfClass:[SpellSelectorViewController class]]){
        self.coverView.hidden = NO;
        self.shouldSelectSpellTarget = YES;
        
        self.selectedSpell = [(SpellSelectorViewController*)segue.sourceViewController selectedSpell];
        
        if (self.selectedSpell.canTargetEnemies && self.selectedSpell.canTargetFriendlies){
            [self coverNeither];
        } else if (self.selectedSpell.canTargetEnemies){
            [self coverFriendly];
        } else if (self.selectedSpell.canTargetFriendlies){
            [self coverEnemy];
        } else {
            [self coverBoth];
        }
    }
}

-(IBAction)segueReturn:(UIStoryboardSegue*)segue{
    [self coverReset];
    [self updateGUI];
}

-(IBAction)segueCreateMinion:(UIStoryboardSegue*)segue{
    UIViewController* source = segue.sourceViewController;
    if ([source isKindOfClass:[MinionAddController class]]){
        MinionAddController* minionSource = (MinionAddController*)source;
        Minion* newMinion = [[Minion alloc]initWithHealth:minionSource.currentHealth Speed:minionSource.currentSpeed shield:minionSource.currentShield];
        [self setMinion:newMinion forTag:self.selectedTag];
        self.game.homePlayer.mana -= [Game minionCreateCost];
        [self update];
    }
}

- (IBAction)addSoul {
    self.coverView.hidden = NO;
    [self coverEnemy];
    [self highlightHomeMinions];
    self.shouldAddSoul = YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toSpells"]){
        SpellSelectorViewController* dest = (SpellSelectorViewController*)segue.destinationViewController;
        dest.sourceMinion = self.selectedMinion;
    } else if ([segue.identifier isEqualToString:@"toSoulAdd"]){
        SoulAddController* dest = (SoulAddController*)segue.destinationViewController;
        dest.selectedMinion = self.selectedMinion;
    }
}

- (IBAction)addMinion:(UIButton *)sender {
    self.selectedTag = sender.tag;
    
    [self performSegueWithIdentifier:@"toAddMinion" sender:self];
}


@end
