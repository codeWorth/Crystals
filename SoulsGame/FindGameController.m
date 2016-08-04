//
//  FindGameController.m
//  SoulsGame
//
//  Created by Andrew Cummings on 8/4/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "FindGameController.h"

@interface FindGameController ()

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;

@end

@implementation FindGameController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self setUserInfo];
}

- (IBAction)findMatch {
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/addtoqueue.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSTimer* timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(scanMatches:) userInfo:nil repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        }];
        
        [uploadTask resume];
    }
}

-(void)scanMatches:(NSTimer*)timer{
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/data.php"];
    
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
                NSTimer* timer = [NSTimer timerWithTimeInterval:4.0 target:self selector:@selector(scanMatches:) userInfo:nil repeats:NO];
                [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            }
        }];
        
        [uploadTask resume];
    }
}

-(void)matchFound{
    [self performSegueWithIdentifier:@"matchFound" sender:self];
}

-(void)setUserInfo{
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/playerdata.php"];
    
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
            self.rankLabel.text = [items objectAtIndex:1];
        }];
        
        [uploadTask resume];
    }
}

@end
