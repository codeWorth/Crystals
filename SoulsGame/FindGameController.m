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
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/souls/addtoqueue.php", [Game serverIP]]];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            self.findingLabel.hidden = NO;
            self.findButton.hidden = YES;
            self.cancelButton.hidden = NO;
            
            NSTimer* timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(scanMatches:) userInfo:nil repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        }];
        
        [uploadTask resume];
    }
}

-(void)scanMatches:(NSTimer*)timer{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/souls/getr.php", [Game serverIP]]];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            if ([str length] > 0){
                [self matchFound];
            } else {
                self.findingLabel.text = [NSString stringWithFormat:@"%@.", self.findingLabel.text];
                if ([self.findingLabel.text isEqualToString:@"Finding Match...."]){
                    self.findingLabel.text = @"Finding Match";
                }
                
                NSTimer* timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(scanMatches:) userInfo:nil repeats:NO];
                [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            }
        }];
        
        [uploadTask resume];
    }
}

-(void)matchFound {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/souls/matchdata.php", [Game serverIP]]];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            self.awayID = [str integerValue];
            
            [self performSegueWithIdentifier:@"matchFound" sender:self];
        }];
        
        [uploadTask resume];
    }
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
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/souls/playerdata.php", [Game serverIP]]];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSArray* items = [str componentsSeparatedByString:@","];
            
            self.usernameLabel.text = [items objectAtIndex:0];
            self.rankLabel.text = [NSString stringWithFormat:@"Rank: %@", [items objectAtIndex:1]];
        }];
        
        [uploadTask resume];
    }
}

- (IBAction)cancelSearch {
    if ([Game instance].offline) {
        [self performSegueWithIdentifier:@"return" sender:self];
        return;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/souls/attemptcancel.php", [Game serverIP]]];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            if ([str isEqualToString:@"y"]) {
                [self performSegueWithIdentifier:@"return" sender:self];
            }
        }];
        
        [uploadTask resume];
    }
}

@end
