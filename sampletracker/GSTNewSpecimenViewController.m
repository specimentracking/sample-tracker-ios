//
//  GSTNewSpecimenViewController.m
//  sampletracker
//
//  Created by Ondřej Fabián on 02/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTNewSpecimenViewController.h"
#import "GSTLocationPickerViewController.h"
#import "GSTLocation.h"

@interface GSTNewSpecimenViewController ()

@property (weak, nonatomic) IBOutlet UILabel *locationValueLabel;

@end

@implementation GSTNewSpecimenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *locationIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_LAST_LOCATION];
    if (locationIdentifier) {
        GSTLocation *location = [[GSTLocation alloc] initWithIdentifier:locationIdentifier];
        self.locationValueLabel.text = location.description;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"openLocationPicker"]) {
        GSTLocationPickerViewController *pickerController = segue.destinationViewController;
        pickerController.delegate = self;
        NSString *locationIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_LAST_LOCATION];
        if (locationIdentifier) {
            GSTLocation *location = [[GSTLocation alloc] initWithIdentifier:locationIdentifier];
            pickerController.location = location;
        }
    }
}

#pragma mark - Location picker

- (void)locationPicker:(GSTLocationPickerViewController *)picker didPickLocation:(GSTLocation *)location {
    [[NSUserDefaults standardUserDefaults] setObject:location.locationIdentifier forKey:SETTINGS_LAST_LOCATION];
    self.locationValueLabel.text = location.description;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
