//
//  GSTNewSpecimenViewController.m
//  sampletracker
//
//  Created by Ondřej Fabián on 02/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTSpecimenViewController.h"
#import "GSTLocationPickerViewController.h"
#import "GSTTypePickerViewController.h"
#import "GSTSpecimenLocationModel.h"

@interface GSTSpecimenViewController ()
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;

@end

@implementation GSTSpecimenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self.specimen) {
        self.specimen = [[GSTSpecimenModel alloc] init];
        self.specimen.location = [[GSTSpecimenLocationModel alloc] initWithIdentifier:[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_LAST_LOCATION]];
        self.specimen.type = [[GSTSpecimenTypeModel alloc] initWithIdentifier:[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_LAST_TYPE]];
    }
    
    if (self.specimen.location) {
        [self.locationButton setTitle:self.specimen.location.description forState:UIControlStateNormal];
    }
    if (self.specimen.type) {
        [self.typeButton setTitle:self.specimen.type.description forState:UIControlStateNormal];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"openLocationPicker"]) {
        GSTLocationPickerViewController *pickerController = segue.destinationViewController;
        pickerController.delegate = self;
        pickerController.location = self.specimen.location;
    } else if ([segue.identifier isEqualToString:@"openTypePicker"]) {
        GSTTypePickerViewController *pickerController = segue.destinationViewController;
        pickerController.delegate = self;
        pickerController.type = self.specimen.type;
    }
}

#pragma mark - Auxiliary

#pragma mark - Location picker

- (void)locationPicker:(GSTLocationPickerViewController *)picker didPickLocation:(GSTSpecimenLocationModel *)location {
    [[NSUserDefaults standardUserDefaults] setObject:location.locationIdentifier forKey:SETTINGS_LAST_LOCATION];
    [self.locationButton setTitle:location.description forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)typePicker:(GSTTypePickerViewController *)picker didPickType:(GSTSpecimenTypeModel *)type {
    [[NSUserDefaults standardUserDefaults] setObject:type.typeIdentifier forKey:SETTINGS_LAST_TYPE];
    [self.typeButton setTitle:type.description forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
