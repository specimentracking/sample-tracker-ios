//
//  GSTSettingsViewController.m
//  sampletracker
//
//  Created by Ondřej Fabián on 02/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTSettingsViewController.h"
#import "GSTRESTResource.h"

@interface GSTSettingsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *apiTextField;
@property (weak, nonatomic) IBOutlet UITextField *pidTextField;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;

@end

@implementation GSTSettingsViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.title = @"Settings";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.apiTextField.text = [userDefaults objectForKey:SETTINGS_API_KEY];
    self.pidTextField.text = [userDefaults objectForKey:SETTINGS_PROJECT_ID];
    self.urlTextField.text = GST_BASE_URL;
}

#pragma mark - Actions

- (IBAction)save:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.apiTextField.text forKey:SETTINGS_API_KEY];
    [userDefaults setObject:self.pidTextField.text forKey:SETTINGS_PROJECT_ID];
    [userDefaults setObject:self.urlTextField.text forKey:SETTINGS_BASE_URL];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.apiTextField) {
        [self.pidTextField becomeFirstResponder];
    } else if (textField == self.pidTextField) {
        [self.view endEditing:YES];
    }
    return NO;
}

@end
