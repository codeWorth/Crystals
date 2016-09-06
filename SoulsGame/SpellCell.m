//
//  SpellCell.m
//  SoulsGame
//
//  Created by Andrew Cummings on 6/6/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "SpellCell.h"

@interface SpellCell ()

@property (weak, nonatomic) IBOutlet UIImageView *spellImg;
@property (weak, nonatomic) IBOutlet UILabel *spellNameLabel;

@end

@implementation SpellCell

-(void)updateWith:(Spell*)spell{
    self.spell = spell;
    
    self.spellImg.image = spell.img;
    self.spellNameLabel.text = spell.name;
    self.backgroundColor = [SpellCell colorFromType:spell.type];
}

+(UIColor*)colorFromType:(ElementType)type{
    if (type == ElementTypeFire){
        return [UIColor redColor];
    } else if (type == ElementTypeLife){
        return [UIColor greenColor];
    } else if (type == ElementTypeWater) {
        return [UIColor colorWithRed:128 green:204 blue:237 alpha:1.0];
    }else {
        return [UIColor grayColor];
    }
}

@end
