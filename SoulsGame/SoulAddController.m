//
//  SoulAdd.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/1/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "SoulAddController.h"
#import "BattlefieldController.h"
#import "SoulSelectionController.h"

#define BASE_STAT_WIDTH 40

@interface SoulAddController ()

@property (nonatomic, strong) UIImageView* selectedImage;
@property (nonatomic) SoulType selectedType;

@property (weak, nonatomic) IBOutlet UILabel *shield;
@property (weak, nonatomic) IBOutlet UILabel *speed;
@property (weak, nonatomic) IBOutlet UILabel *health;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray* soulItems;

@property (weak, nonatomic) IBOutlet UIImageView *innerSoulBackground;
@property (weak, nonatomic) IBOutlet UIImageView *middleSoulBackground;
@property (weak, nonatomic) IBOutlet UIImageView *outerSoulBackground;

@end

@implementation SoulAddController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSComparator compareTags = ^(id a, id b) {
        NSInteger aTag = [b tag];
        NSInteger bTag = [a tag];
        return aTag < bTag ? NSOrderedDescending
        : aTag > bTag ? NSOrderedAscending
        : NSOrderedSame;
    };
    self.soulItems = [self.soulItems sortedArrayUsingComparator:compareTags];
    
    self.shield.layer.cornerRadius = BASE_STAT_WIDTH/2;
    self.shield.clipsToBounds = YES;
    
    self.speed.layer.cornerRadius = BASE_STAT_WIDTH/2;
    self.speed.clipsToBounds = YES;
    
    self.health.layer.cornerRadius = BASE_STAT_WIDTH/2;
    self.health.clipsToBounds = YES;
    
    self.shield.text = @([self.selectedMinion shield]).stringValue;
    self.speed.text = @([self.selectedMinion speed]).stringValue;
    self.health.text = @([self.selectedMinion health]).stringValue;
    
    self.innerSoulBackground.hidden = YES;
    self.middleSoulBackground.hidden = YES;
    self.outerSoulBackground.hidden = YES;
    
    [self highlightFilledRings];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self unpackMinion];
}

- (IBAction)imageTapped:(UITapGestureRecognizer *)sender {
    UIImageView* imageTapped = (UIImageView*)sender.view;
    self.selectedImage = imageTapped;
    
    if (self.selectedImage.tag < 4){
        self.selectedType = Resist;
    } else if (self.selectedImage.tag < 8){
        self.selectedType = Buff;
    } else if (self.selectedImage.tag < 11){
        self.selectedType = Specialized;
    }
    
    [self performSegueWithIdentifier:@"toSoulAdd" sender:self];
}

-(IBAction)segueUseSoul:(UIStoryboardSegue*)segue{
    if ([segue.sourceViewController isKindOfClass:[SoulSelectionController class]]){
        NSObject<Soul>* soul = ((SoulSelectionController*)segue.sourceViewController).selectedSoul;
        
        self.selectedImage.image = soul.img;
        [Game instance].homePlayer.mana -= soul.cost;
        [self.selectedMinion addSoul:soul atIndex:self.selectedImage.tag-1];
        [self highlightFilledRings];
        
        self.selectedImage.layer.cornerRadius = self.selectedImage.frame.size.width/2;
        self.selectedImage.clipsToBounds = YES;
    }
}

-(IBAction)segueCancelUse:(UIStoryboardSegue*)segue{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toSoulAdd"]){
        SoulSelectionController* dest = (SoulSelectionController*)segue.destinationViewController;
        
        dest.selectedType = self.selectedType;
    }
}

-(void)unpackMinion{
    for (UIImageView* imgView in self.soulItems){
        if ([self.selectedMinion getSoulAtIndex:imgView.tag-1] != [NSNull null]){
            imgView.image = ((NSObject<Soul>*)[self.selectedMinion getSoulAtIndex:imgView.tag-1]).img;

            imgView.layer.cornerRadius = imgView.frame.size.width/2;
            imgView.clipsToBounds = YES;
        }
    }
}

-(void)highlightFilledRings{
    if ([self.selectedMinion getResistSouls].count == 3){
        self.outerSoulBackground.hidden = NO;
    }
    if ([self.selectedMinion getBuffSouls].count == 4){
        self.middleSoulBackground.hidden = NO;
    }
    if ([self.selectedMinion getSpecSouls].count == 3){
        self.innerSoulBackground.hidden = NO;
    }
}

@end
