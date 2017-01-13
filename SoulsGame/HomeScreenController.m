//
//  homeScreenController.m
//  SoulsGame
//
//  Created by Andrew Cummings on 7/26/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "HomeScreenController.h"
#import "FindGameController.h"
#import "Game.h"
#import "SocketHandler.h"

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

@property (nonatomic) NSInteger viewOffset;
@property (nonatomic) NSInteger kbHeight;
@property (nonatomic) BOOL delayKb;

@end

@implementation HomeScreenController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    if ([Game instance].offline) {
        self.LoginView.hidden = YES;
        self.MainView.hidden = NO;
        
        self.usernameLabel.text = @"Offline";
        return;
    }
    
    [[SocketHandler getInstance] initNetworkCommunication];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults stringForKey:@"username"];
    NSString* password = [defaults stringForKey:@"password"];

    self.LoginView.hidden = NO;
    self.MainView.hidden = YES;
    
    self.delayKb = YES;
    
    if ([username length] == 0 ||  [password length] == 0){
        return;
    }
    
    self.saveCredentials.on = YES;
    
    self.UsernameField.text = username;
    self.PasswordField.text = password;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification*)notification {
    self.kbHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height + 15; //so there is some padding between the textfield and the keyboard
    
    if (self.delayKb){
        self.delayKb = NO;
        self.viewOffset = self.PasswordField.frame.origin.y + self.PasswordField.frame.size.height - (self.view.frame.size.height - self.kbHeight); //viewOffset is temporarily textfield y
        self.viewOffset = self.viewOffset < 0 ? 0 : self.viewOffset;
        [self animateTextField:YES];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField { //this trigger BEFORE keyboardWillShow
    if (!self.delayKb){
        self.viewOffset = self.PasswordField.frame.origin.y + self.PasswordField.frame.size.height - (self.view.frame.size.height - self.kbHeight);
        self.viewOffset = self.viewOffset < 0 ? 0 : self.viewOffset;
        [self animateTextField:YES];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField:NO];
}

-(void)animateTextField:(BOOL)up {
    NSInteger movement = up ? -self.viewOffset : self.viewOffset;
    
    [UIView animateWithDuration:0.3 animations:^(void){
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    }];
}

-(void)setIDForUsername:(NSString*)username andPassword:(NSString*)password {
    /*NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/souls/login.php", [Game serverIP]]];
    NSString* params = [NSString stringWithFormat:@"name=%@&pass=%@", username, password];
    self.userID = [str intValue];
    
    self.usernameLabel.text = [NSString stringWithFormat:@"Welcome %@", username];
    
    if (self.userID > 0){
        if (self.saveCredentials.on) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:self.UsernameField.text forKey:@"username"];
            [defaults setObject:self.PasswordField.text forKey:@"password"];
        } else {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"" forKey:@"username"];
            [defaults setObject:@"" forKey:@"password"];
        }
        
        self.LoginView.hidden = YES;
        self.MainView.hidden = NO;
    } else {
        self.errorLabel.text = @"Invalid username/password.";
        self.UsernameField.text = @"";
        self.PasswordField.text = @"";
    }*/
}

- (IBAction)login {
    [self setIDForUsername:self.UsernameField.text andPassword:self.PasswordField.text];
}

- (IBAction)register {
    /*NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/souls/adduser.php", [Game serverIP]]];
    NSString* params = [NSString stringWithFormat:@"name=%@&pass=%@", self.UsernameField.text, self.PasswordField.text];
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
    }*/
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toFindMatch"]){
        FindGameController* dest = (FindGameController*)segue.destinationViewController;
        dest.userID = self.userID;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)segueReturn:(UIStoryboardSegue*)segue {
    
}

@end
