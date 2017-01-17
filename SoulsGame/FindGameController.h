//
//  FindGameController.h
//  SoulsGame
//
//  Created by Andrew Cummings on 8/4/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketHandler.h"

@interface FindGameController : UIViewController <QueueDelegate>

@property (nonatomic) NSInteger userID;

@end
