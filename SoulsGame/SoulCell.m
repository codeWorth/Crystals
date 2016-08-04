
//
//  SoulCell.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/4/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "SoulCell.h"

@interface SoulCell ()

@property (weak, nonatomic) IBOutlet UIImageView *soulImg;
@property (weak, nonatomic) IBOutlet UILabel *soulName;
@property (weak, nonatomic) IBOutlet UITextView *soulDesc;

@end

@implementation SoulCell

-(void)setupWithSoul:(NSObject<Soul>*)soul{
    self.soulImg.image = soul.img;
    self.soulName.text = soul.name;
    self.soulDesc.text = soul.desc;
    
    self.soul = soul;
}

@end
