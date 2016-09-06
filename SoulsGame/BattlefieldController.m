//
//  ViewController.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "BattlefieldController.h"
#import "Game.h"
#import "CrystalView.h"
#import "SpellSelectorViewController.h"
#import "SoulAddController.h"
#import "CrystalAddController.h"
#import "TransparentCover.h"

#define CRYSTAL_H1_TAG 1
#define CRYSTAL_H2_TAG 2
#define CRYSTAL_H3_TAG 3
#define CRYSTAL_H4_TAG 4
#define CRYSTAL_H5_TAG 5
#define CRYSTAL_A1_TAG 6
#define CRYSTAL_A2_TAG 7
#define CRYSTAL_A3_TAG 8
#define CRYSTAL_A4_TAG 9
#define CRYSTAL_A5_TAG 10

@interface BattlefieldController ()

@property (nonatomic, weak) IBOutlet UILabel* timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextTurnButton;

@property (nonatomic, weak) IBOutlet CrystalView* crystalH1;
@property (nonatomic, weak) IBOutlet CrystalView* crystalH2;
@property (nonatomic, weak) IBOutlet CrystalView* crystalH3;
@property (nonatomic, weak) IBOutlet CrystalView* crystalH4;
@property (nonatomic, weak) IBOutlet CrystalView* crystalH5;

@property (nonatomic, weak) IBOutlet CrystalView* crystalA1;
@property (nonatomic, weak) IBOutlet CrystalView* crystalA2;
@property (nonatomic, weak) IBOutlet CrystalView* crystalA3;
@property (nonatomic, weak) IBOutlet CrystalView* crystalA4;
@property (nonatomic, weak) IBOutlet CrystalView* crystalA5;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *AwayHighlights;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *HomeHighlights;

@property (weak, nonatomic) IBOutlet UIButton *crystalAdd1;
@property (weak, nonatomic) IBOutlet UIButton *crystalAdd2;
@property (weak, nonatomic) IBOutlet UIButton *crystalAdd3;
@property (weak, nonatomic) IBOutlet UIButton *crystalAdd4;
@property (weak, nonatomic) IBOutlet UIButton *crystalAdd5;
@property (weak, nonatomic) IBOutlet TransparentCover *crystalAddContainer;

@property (nonatomic, weak) IBOutlet UILabel* manaLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnLabel;

@property (nonatomic, weak) IBOutlet UIImageView* homeImg;
@property (nonatomic, weak) IBOutlet UILabel* homeName;

@property (nonatomic, weak) IBOutlet UIImageView* awayImg;
@property (nonatomic, weak) IBOutlet UILabel* awayName;

@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIView *homeHighlightsView;
@property (weak, nonatomic) IBOutlet UIView *awayHighlightsView;

@property (nonatomic, strong) Spell* selectedSpell;
@property (nonatomic) BOOL shouldSelectSpellTarget;

@property (nonatomic) BOOL shouldAddSoul;

@property (nonatomic, strong) Game* game;
@property (nonatomic, strong) Crystal* selectedCrystal;
@property (nonatomic) NSInteger selectedTag;

@property (nonatomic) NSString* awayUsername;

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
    
    self.nextTurnButton.enabled = NO;
    
    [self hideAllHighlights];
    
    self.game = [Game instance];
    [self.game setDelegate:self];
    [self updateHomeUser];
    [self setAwayInfo];
    [self updateGUI];
    
    [self coverReset];
    
    self.crystalH1.tag = CRYSTAL_H1_TAG;
    self.crystalH2.tag = CRYSTAL_H2_TAG;
    self.crystalH3.tag = CRYSTAL_H3_TAG;
    self.crystalH4.tag = CRYSTAL_H4_TAG;
    self.crystalH5.tag = CRYSTAL_H5_TAG;
    
    self.crystalA1.tag = CRYSTAL_A1_TAG;
    self.crystalA2.tag = CRYSTAL_A2_TAG;
    self.crystalA3.tag = CRYSTAL_A3_TAG;
    self.crystalA4.tag = CRYSTAL_A4_TAG;
    self.crystalA5.tag = CRYSTAL_A5_TAG;
    
    self.crystalAdd1.tag = CRYSTAL_H1_TAG;
    self.crystalAdd2.tag = CRYSTAL_H2_TAG;
    self.crystalAdd3.tag = CRYSTAL_H3_TAG;
    self.crystalAdd4.tag = CRYSTAL_H4_TAG;
    self.crystalAdd5.tag = CRYSTAL_H5_TAG;
    
    [self.game setShouldStart];
}

-(void)setAwayInfo {
    if (self.game.offline) {
        self.awayUsername = @"BOT";
        [self updateAwayUser];
        
        return;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/souls/playerdata.php", [Game serverIP]]];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.awayID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSArray* items = [str componentsSeparatedByString:@","];
            
            self.awayUsername = (NSString*)[items objectAtIndex:0];
            
            [self updateAwayUser];
        }];
        
        [uploadTask resume];
    }
}

-(Crystal*)crystalForTag:(NSInteger)tag{
    if (tag == CRYSTAL_H1_TAG){
        return self.game.homePlayer.crystal1;
    } else if (tag == CRYSTAL_H2_TAG){
        return self.game.homePlayer.crystal2;
    } else if (tag == CRYSTAL_H3_TAG){
        return self.game.homePlayer.crystal3;
    } else if (tag == CRYSTAL_H4_TAG){
        return self.game.homePlayer.crystal4;
    } else if (tag == CRYSTAL_H5_TAG){
        return self.game.homePlayer.crystal5;
    } else if (tag == CRYSTAL_A1_TAG){
        return self.game.awayPlayer.crystal1;
    } else if (tag == CRYSTAL_A2_TAG){
        return self.game.awayPlayer.crystal2;
    } else if (tag == CRYSTAL_A3_TAG){
        return self.game.awayPlayer.crystal3;
    } else if (tag == CRYSTAL_A4_TAG){
        return self.game.awayPlayer.crystal4;
    } else if (tag == CRYSTAL_A5_TAG){
        return self.game.awayPlayer.crystal5;
    } else {
        return nil;
    }
}

-(void)setCrystal:(Crystal*)crystal forTag:(NSInteger)tag{
    if (tag == CRYSTAL_H1_TAG){
        self.game.homePlayer.crystal1 = crystal;
    } else if (tag == CRYSTAL_H2_TAG){
        self.game.homePlayer.crystal2 = crystal;
    } else if (tag == CRYSTAL_H3_TAG){
        self.game.homePlayer.crystal3 = crystal;
    } else if (tag == CRYSTAL_H4_TAG){
        self.game.homePlayer.crystal4 = crystal;
    } else if (tag == CRYSTAL_H5_TAG){
        self.game.homePlayer.crystal5 = crystal;
    }
}

-(void)updateGUI{
    [self updateTimeLabel];
    [self updateManaLabel];
    
    [self.crystalH1 updateWithCrystal:[self.game.homePlayer crystal1]];
    [self.crystalH2 updateWithCrystal:[self.game.homePlayer crystal2]];
    [self.crystalH3 updateWithCrystal:[self.game.homePlayer crystal3]];
    [self.crystalH4 updateWithCrystal:[self.game.homePlayer crystal4]];
    [self.crystalH5 updateWithCrystal:[self.game.homePlayer crystal5]];
    
    [self.crystalA1 updateWithCrystal:[self.game.awayPlayer crystal1]];
    [self.crystalA2 updateWithCrystal:[self.game.awayPlayer crystal2]];
    [self.crystalA3 updateWithCrystal:[self.game.awayPlayer crystal3]];
    [self.crystalA4 updateWithCrystal:[self.game.awayPlayer crystal4]];
    [self.crystalA5 updateWithCrystal:[self.game.awayPlayer crystal5]];
    
    [self hideAllHighlights];
    
    if (self.game.canAttack){
        self.nextTurnButton.enabled = YES;
        self.turnLabel.text = @"Your Turn";
        [self showHomeHighlights];
    } else {
        self.nextTurnButton.enabled = NO;
        self.turnLabel.text = @"Enemy Turn";
    }
}

-(void)checkCrystalDeath{
    [self.game checkCrystalDeath];
    [self updateGUI];
}

-(IBAction)nextTurn{
    [self.game homeEndTurn];
    [self updateGUI];
}

- (IBAction)exit {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Exit this match?"
                                 message:@"You cannot rejoin."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Exit"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self.game endGame];
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {}];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)exitSegue {
    [self performSegueWithIdentifier:@"exit" sender:self];
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
    if ([self.game.homePlayer crystal1] != nil && [[self.game.homePlayer crystal1] cooldown] == 0){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:0]).hidden = NO;
    }
    if ([self.game.homePlayer crystal2] != nil && [[self.game.homePlayer crystal2] cooldown] == 0){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:1]).hidden = NO;
    }
    if ([self.game.homePlayer crystal3] != nil && [[self.game.homePlayer crystal3] cooldown] == 0){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:2]).hidden = NO;
    }
    if ([self.game.homePlayer crystal4] != nil && [[self.game.homePlayer crystal4] cooldown] == 0){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:3]).hidden = NO;
    }
    if ([self.game.homePlayer crystal5] != nil && [[self.game.homePlayer crystal5] cooldown] == 0){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:4]).hidden = NO;
    }
}

-(void)highlightHomeCrystals {
    if ([self.game.homePlayer crystal1] != nil){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:0]).hidden = NO;
    }
    if ([self.game.homePlayer crystal2] != nil){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:1]).hidden = NO;
    }
    if ([self.game.homePlayer crystal3] != nil){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:2]).hidden = NO;
    }
    if ([self.game.homePlayer crystal4] != nil){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:3]).hidden = NO;
    }
    if ([self.game.homePlayer crystal5] != nil){
        ((UIImageView*)[self.HomeHighlights objectAtIndex:4]).hidden = NO;
    }
}

-(void)coverBoth{
    [self.view bringSubviewToFront:self.coverView];
}

-(void)homeCrystalsToFront{
    [self.view bringSubviewToFront:self.crystalH1];
    [self.view bringSubviewToFront:self.crystalH2];
    [self.view bringSubviewToFront:self.crystalH3];
    [self.view bringSubviewToFront:self.crystalH4];
    [self.view bringSubviewToFront:self.crystalH5];
}

-(void)awayCrystalsToFront{
    [self.view bringSubviewToFront:self.crystalA1];
    [self.view bringSubviewToFront:self.crystalA2];
    [self.view bringSubviewToFront:self.crystalA3];
    [self.view bringSubviewToFront:self.crystalA4];
    [self.view bringSubviewToFront:self.crystalA5];
}

-(void)coverFriendly{
    [self.view bringSubviewToFront:self.coverView];
    [self.view bringSubviewToFront:self.awayHighlightsView];
    [self awayCrystalsToFront];
}

-(void)coverEnemy{
    [self.view bringSubviewToFront:self.coverView];
    [self.view bringSubviewToFront:self.homeHighlightsView];
    [self homeCrystalsToFront];
}

-(void)coverNeither{
    [self.view bringSubviewToFront:self.homeHighlightsView];
    [self homeCrystalsToFront];
    [self.view bringSubviewToFront:self.awayHighlightsView];
    [self awayCrystalsToFront];
}

-(void)coverReset{
    self.coverView.hidden = YES;
    [self.view bringSubviewToFront:self.homeHighlightsView];
    [self.view bringSubviewToFront:self.crystalAddContainer];
    [self homeCrystalsToFront];
}

-(void)updateTimeLabel{
    self.timeLabel.text = [NSString stringWithFormat:@"Time: %i",(int)self.game.time];
}

-(void)updateManaLabel{
    self.manaLabel.text = [NSString stringWithFormat:@"Mana: %i",(int)self.game.homePlayer.mana];
}

-(void)updateHomeUser{
    self.homeImg.image = self.game.homePlayer.profileImg;
    self.homeName.text = self.username;
}

-(void)updateAwayUser{
    self.awayImg.image = self.game.awayPlayer.profileImg;
    self.awayName.text = self.awayUsername;
}

- (IBAction)coverPressed:(UITapGestureRecognizer *)sender {
    self.shouldAddSoul = NO;
    self.shouldSelectSpellTarget = NO;
    
    [self coverReset];
    [self updateGUI];
}


- (IBAction)enemyCrystalSelected:(CrystalView *)sender {
    if (self.shouldSelectSpellTarget){
        [self castSpellOnCrystal:[self crystalForTag:sender.tag]];
    }
}

- (IBAction)friendlyCrystalSelected:(CrystalView *)sender {
    Crystal* crystal = [self crystalForTag:sender.tag];
    
    if (self.shouldSelectSpellTarget) {
        [self castSpellOnCrystal:crystal];
    } else if (self.game.canAttack) {
        if (self.shouldAddSoul){
            self.shouldAddSoul = NO;
            [self coverReset];
            self.selectedCrystal = crystal;
            
            [self performSegueWithIdentifier:@"toSoulAdd" sender:self];
        } else {
            if ([crystal canCastSpell]){
                self.selectedCrystal = crystal;
                
                [self performSegueWithIdentifier:@"toSpells" sender:self];
            } else {
                NSLog(@"cant cast rn soz");
            }
        }
    }
}

-(void)castSpellOnCrystal:(Crystal*)crystal{
    [self coverReset];
    self.shouldSelectSpellTarget = NO;
    
    self.game.homePlayer.mana -= self.selectedSpell.cost;
    
    [self.selectedCrystal castSpell:self.selectedSpell onTarget:crystal];
    [self checkCrystalDeath];
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
            self.coverView.hidden = YES;
            self.shouldSelectSpellTarget = NO;
            [self castSpellOnCrystal:self.selectedCrystal];
        }
    }
}

-(IBAction)segueReturn:(UIStoryboardSegue*)segue{
    [self coverReset];
    [self updateGUI];
}

-(IBAction)segueCreateCrystal:(UIStoryboardSegue*)segue{
    UIViewController* sourceController = segue.sourceViewController;
    if ([sourceController isKindOfClass:[CrystalAddController class]]){
        CrystalAddController* source = (CrystalAddController*)sourceController;
        Crystal* newCrystal = [[Crystal alloc]initWithHealth:source.currentHealth Speed:source.currentSpeed shield:source.currentShield];
        
        self.nextTurnButton.enabled = YES;
        
        [self setCrystal:newCrystal forTag:self.selectedTag];
        self.game.homePlayer.mana -= [Game crystalCreateCost];
        [self updateGUI];
    }
}

- (IBAction)addSoul {
    if (!self.game.canAttack){
        return;
    }
    
    self.coverView.hidden = NO;
    [self coverEnemy];
    [self highlightHomeCrystals];
    self.shouldAddSoul = YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toSpells"]){
        SpellSelectorViewController* dest = (SpellSelectorViewController*)segue.destinationViewController;
        dest.sourceCrystal = self.selectedCrystal;
    } else if ([segue.identifier isEqualToString:@"toSoulAdd"]){
        SoulAddController* dest = (SoulAddController*)segue.destinationViewController;
        dest.selectedCrystal = self.selectedCrystal;
    }
}

- (IBAction)addCrystal:(UIButton *)sender {
    if (!self.game.canAttack) {
        return;
    }
    
    self.selectedTag = sender.tag;
    
    [self performSegueWithIdentifier:@"toAddCrystal" sender:self];
}

@end
