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

@property (weak, nonatomic) IBOutlet UILabel *ngsLabel;
@property (weak, nonatomic) IBOutlet UILabel *sgrLabel;
@property (weak, nonatomic) IBOutlet UILabel *genLabel;
@property (weak, nonatomic) IBOutlet UILabel *hapLabel;
@property (weak, nonatomic) IBOutlet UILabel *pcrLabel;



@end

@implementation GSTSpecimenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self.specimen) {
        self.specimen = [[GSTSpecimenModel alloc] init];
        self.specimen.location = [[GSTSpecimenLocationModel alloc] initWithIdentifier:[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_LAST_LOCATION]];
        self.specimen.type = [[GSTSpecimenTypeModel alloc] initWithIdentifier:[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_LAST_TYPE]];
        self.ngsLabel.hidden = YES;
        self.sgrLabel.hidden = YES;
        self.genLabel.hidden = YES;
        self.hapLabel.hidden = YES;
        self.pcrLabel.hidden = YES;
    } else {
        self.ngsLabel.textColor = self.specimen.ngsSegFlag?[UIColor greenColor]:[UIColor blackColor];
        self.sgrLabel.textColor = self.specimen.sangerSeqFlag?[UIColor greenColor]:[UIColor blackColor];
        self.genLabel.textColor = self.specimen.genotypeFlag?[UIColor greenColor]:[UIColor blackColor];
        self.hapLabel.textColor = self.specimen.haplotypeFlag?[UIColor greenColor]:[UIColor blackColor];
        self.pcrLabel.textColor = self.specimen.ddPcrFlag?[UIColor greenColor]:[UIColor blackColor];
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
    self.specimen.location = location;
    [self.locationButton setTitle:location.description forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)typePicker:(GSTTypePickerViewController *)picker didPickType:(GSTSpecimenTypeModel *)type {
    [[NSUserDefaults standardUserDefaults] setObject:type.typeIdentifier forKey:SETTINGS_LAST_TYPE];
    self.specimen.type = type;
    [self.typeButton setTitle:type.description forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
