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
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet UIView *MainView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *navButtons;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UISwitch *saveCredentials;

@property (nonatomic) NSInteger userID;
@property (nonatomic, weak) UITextField* activeField;

@end

@implementation HomeScreenController

-(void)viewDidLoad{
    [super viewDidLoad];
        
    for (UIButton* button in self.navButtons) {
        button.enabled = NO;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults stringForKey:@"username"];
    NSString* password = [defaults stringForKey:@"password"];

    self.LoginView.hidden = NO;
    self.MainView.hidden = YES;
    
    if (username == nil || password == nil){
        return;
    }
    
    self.saveCredentials.on = YES;
    
    self.UsernameField.text = username;
    self.PasswordField.text = password;
}

-(void)setIDForUsername:(NSString*)username andPassword:(NSString*)password {
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
            
            if (self.userID > 0){
                if (self.saveCredentials.on) {
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    
                    [defaults setObject:self.UsernameField.text forKey:@"username"];
                    [defaults setObject:self.PasswordField.text forKey:@"password"];
                }
                
                self.LoginView.hidden = YES;
                self.MainView.hidden = NO;
            } else {
                self.errorLabel.text = @"Invalid username/password.";
                self.UsernameField.text = @"";
                self.PasswordField.text = @"";
            }
        }];
        
        [uploadTask resume];
    }
}

- (IBAction)login {
    [self setIDForUsername:self.UsernameField.text andPassword:self.PasswordField.text];
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
            
            if (self.userID > 0){
                self.LoginView.hidden = YES;
                self.MainView.hidden = NO;
            } else if (self.userID == -1){
                self.errorLabel.text = @"User already exists.";
                self.UsernameField.text = @"";
                self.PasswordField.text = @"";
            } else {
                self.errorLabel.text = @"Couldn't connect.";
                self.UsernameField.text = @"";
                self.PasswordField.text = @"";
            }
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

@end
