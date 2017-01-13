//
//  FindGameController.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/4/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "FindGameController.h"
#import "BattlefieldController.h"
#import "Game.h"

@interface FindGameController ()

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UIButton *findButton;
@property (weak, nonatomic) IBOutlet UILabel *findingLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (nonatomic) NSInteger awayID;

@end

@implementation FindGameController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self setUserInfo];
    self.cancelButton.hidden = YES;
}

- (IBAction)findMatch {
    if ([Game instance].offline) {
        [self performSegueWithIdentifier:@"matchFound" sender:self];
        return;
    }
    
    /*NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/souls/addtoqueue.php", [Game serverIP]]];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    NOPE
    self.findingLabel.hidden = NO;
    self.findButton.hidden = YES;
    self.cancelButton.hidden = NO;*/
    
}

-(void)scanMatches:(NSTimer*)timer{
    /*NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/souls/getr.php", [Game serverIP]]];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    
    if ([str length] > 0){
        [self matchFound];
    } else {
        self.findingLabel.text = [NSString stringWithFormat:@"%@.", self.findingLabel.text];
        if ([self.findingLabel.text isEqualToString:@"Finding Match...."]){
            self.findingLabel.text = @"Finding Match";
        }
    }*/
}

-(void)matchFound {
    /*NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/souls/matchdata.php", [Game serverIP]]];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];

    self.awayID = [str integerValue];
    
    [self performSegueWithIdentifier:@"matchFound" sender:self];*/
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[BattlefieldController class]]){
        BattlefieldController* dest = (BattlefieldController*)segue.destinationViewController;
        dest.userID = self.userID;
        dest.awayID = self.awayID;
        dest.username = self.usernameLabel.text;
    }
}

-(void)setUserInfo{
    if ([Game instance].offline) {
        self.usernameLabel.text = @"Offline";
        self.rankLabel.text = @"--";
        return;
    }
    
    /*NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/souls/playerdata.php", [Game serverIP]]];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    NSArray* items = [str componentsSeparatedByString:@","];
    
    self.usernameLabel.text = [items objectAtIndex:0];
    self.rankLabel.text = [NSString stringWithFormat:@"Rank: %@", [items objectAtIndex:1]];*/
}

- (IBAction)cancelSearch {
    if ([Game instance].offline) {
        [self performSegueWithIdentifier:@"return" sender:self];
        return;
    }
    
    /*NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/souls/attemptcancel.php", [Game serverIP]]];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    
    if ([str isEqualToString:@"y"]) {
        [self performSegueWithIdentifier:@"return" sender:self];
    }*/
}

@end
