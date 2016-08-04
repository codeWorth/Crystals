//
//  homeScreenController.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/26/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "HomeScreenController.h"
#import "FindGameController.h"

@interface HomeScreenController ()

@property (weak, nonatomic) IBOutlet UIView *LoginView;
@property (weak, nonatomic) IBOutlet UITextField *UsernameField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordField;

@property (weak, nonatomic) IBOutlet UIView *MainView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *navButtons;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (nonatomic) NSInteger userID;

@end

@implementation HomeScreenController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    for (UIButton* button in self.navButtons) {
        button.enabled = NO;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults stringForKey:@"username"];
    
    if (username == nil){
        self.LoginView.hidden = NO;
        self.MainView.hidden = YES;
        return;
    }
    
    self.LoginView.hidden = YES;
    self.MainView.hidden = NO;
    
    NSString* password = [defaults stringForKey:@"password"];
    
    [self setIDForUsername:username andPassword:password shouldRedirect:NO];
}

-(void)setIDForUsername:(NSString*)username andPassword:(NSString*)password shouldRedirect:(BOOL)redirect {
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/login.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"name=%@&pass=%@", username, password];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            self.userID = [str intValue];
            
            self.usernameLabel.text = [NSString stringWithFormat:@"Welcome %@", username];
            
            for (UIButton* button in self.navButtons) {
                button.enabled = YES;
            }
            
            if (redirect){
                self.LoginView.hidden = YES;
                self.MainView.hidden = NO;
            }
        }];
        
        [uploadTask resume];
    }
}

- (IBAction)login {
    [self setIDForUsername:self.UsernameField.text andPassword:self.PasswordField.text shouldRedirect:YES];
}

- (IBAction)register {
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/adduser.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"name=%@&pass=%@", self.UsernameField.text, self.PasswordField.text];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            self.userID = [str intValue];
            
            self.usernameLabel.text = [NSString stringWithFormat:@"Welcome %@", self.UsernameField.text];
            
            for (UIButton* button in self.navButtons) {
                button.enabled = YES;
            }
    
            self.LoginView.hidden = YES;
            self.MainView.hidden = NO;
        }];
        
        [uploadTask resume];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toFindMatch"]){
        FindGameController* dest = (FindGameController*)segue.destinationViewController;
        dest.userID = self.userID;
    }
}

@end
