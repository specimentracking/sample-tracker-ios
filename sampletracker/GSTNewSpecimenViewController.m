//
//  GSTNewSpecimenViewController.m
//  sampletracker
//
//  Created by Ondřej Fabián on 02/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTNewSpecimenViewController.h"
#import "GSTLocationPickerViewController.h"
#import "GSTTypePickerViewController.h"
#import "GSTSpecimenLocationModel.h"

@interface GSTNewSpecimenViewController ()
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;

@end

@implementation GSTNewSpecimenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *locationIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_LAST_LOCATION];
    if (locationIdentifier) {
        GSTSpecimenLocationModel *location = [[GSTSpecimenLocationModel alloc] initWithIdentifier:locationIdentifier];
        [self.locationButton setTitle:location.description forState:UIControlStateNormal];
    }
    NSString *typeIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_LAST_TYPE];
    if (typeIdentifier) {
        GSTSpecimenTypeModel *type = [[GSTSpecimenTypeModel alloc] initWithIdentifier:typeIdentifier];
        [self.typeButton setTitle:type.description forState:UIControlStateNormal];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"openLocationPicker"]) {
        GSTLocationPickerViewController *pickerController = segue.destinationViewController;
        pickerController.delegate = self;
        NSString *locationIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_LAST_LOCATION];
        if (locationIdentifier) {
            GSTSpecimenLocationModel *location = [[GSTSpecimenLocationModel alloc] initWithIdentifier:locationIdentifier];
            pickerController.location = location;
        }
    } else if ([segue.identifier isEqualToString:@"openTypePicker"]) {
        GSTTypePickerViewController *pickerController = segue.destinationViewController;
        pickerController.delegate = self;
        NSString *typeIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_LAST_TYPE];
        if (typeIdentifier) {
            GSTSpecimenTypeModel *type = [[GSTSpecimenTypeModel alloc] initWithIdentifier:typeIdentifier];
            pickerController.type = type;
        }
    }
}

#pragma mark - Location picker

- (void)locationPicker:(GSTLocationPickerViewController *)picker didPickLocation:(GSTSpecimenLocationModel *)location {
    [[NSUserDefaults standardUserDefaults] setObject:location.locationIdentifier forKey:SETTINGS_LAST_LOCATION];
    [self.locationButton setTitle:location.description forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)typePicker:(GSTTypePickerViewController *)picker didPickType:(GSTSpecimenTypeModel *)type {
    [[NSUserDefaults standardUserDefaults] setObject:type.locationIdentifier forKey:SETTINGS_LAST_TYPE];
    [self.typeButton setTitle:type.description forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
