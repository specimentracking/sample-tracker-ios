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

@property (weak, nonatomic) IBOutlet UIPickerView *statePicker;

@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;

@property (weak, nonatomic) IBOutlet UILabel *ngsLabel;
@property (weak, nonatomic) IBOutlet UILabel *sgrLabel;
@property (weak, nonatomic) IBOutlet UILabel *genLabel;
@property (weak, nonatomic) IBOutlet UILabel *hapLabel;
@property (weak, nonatomic) IBOutlet UILabel *pcrLabel;

@property (weak, nonatomic) IBOutlet UIButton *createDerivativeSampleButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UIButton *createButton;


@end

@implementation GSTSpecimenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Specimen";
    
    if (!self.specimen) {
        self.specimen = [[GSTSpecimenModel alloc] init];
        self.specimen.state = GSTSpecimenStateNew;
        self.specimen.location = [[GSTSpecimenLocationModel alloc] initWithIdentifier:[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_LAST_LOCATION]];
        self.specimen.type = [[GSTSpecimenTypeModel alloc] initWithIdentifier:[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_LAST_TYPE]];
        self.ngsLabel.hidden = YES;
        self.sgrLabel.hidden = YES;
        self.genLabel.hidden = YES;
        self.hapLabel.hidden = YES;
        self.pcrLabel.hidden = YES;
        self.createDerivativeSampleButton.hidden = YES;
        self.saveButton.hidden = YES;
        self.createButton.hidden = NO;
    } else {
        self.ngsLabel.textColor = self.specimen.ngsSegFlag?[UIColor greenColor]:[UIColor blackColor];
        self.sgrLabel.textColor = self.specimen.sangerSeqFlag?[UIColor greenColor]:[UIColor blackColor];
        self.genLabel.textColor = self.specimen.genotypeFlag?[UIColor greenColor]:[UIColor blackColor];
        self.hapLabel.textColor = self.specimen.haplotypeFlag?[UIColor greenColor]:[UIColor blackColor];
        self.pcrLabel.textColor = self.specimen.ddPcrFlag?[UIColor greenColor]:[UIColor blackColor];
        self.createDerivativeSampleButton.hidden = NO;
        self.saveButton.hidden = NO;
        self.createButton.hidden = YES;
    }
    
    if (self.specimen.location) {
        [self.locationButton setTitle:self.specimen.location.description forState:UIControlStateNormal];
    }
    if (self.specimen.type) {
        [self.typeButton setTitle:self.specimen.type.description forState:UIControlStateNormal];
    }
    [self.statePicker selectRow:self.specimen.state inComponent:0 animated:NO];
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

#pragma mark - Actions

- (IBAction)patchSpecimen:(id)sender {
#warning TODO send patch
}

- (IBAction)createDerivate:(id)sender {
#warning TODO start scanner with this specimen as a parent
}

- (IBAction)createSpecimen:(id)sender {
#warning TODO post new specimen
}

#pragma mark - Location picker

- (void)locationPicker:(GSTLocationPickerViewController *)picker didPickLocation:(GSTSpecimenLocationModel *)location {
    [[NSUserDefaults standardUserDefaults] setObject:location.locationIdentifier forKey:SETTINGS_LAST_LOCATION];
    self.specimen.location = location;
    [self.locationButton setTitle:location.description forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)typePicker:(GSTTypePickerViewController *)picker didPickType:(GSTSpecimenTypeModel *)type {
//    [[NSUserDefaults standardUserDefaults] setObject:type.typeIdentifier forKey:SETTINGS_LAST_TYPE];
    self.specimen.type = type;
    [self.typeButton setTitle:type.description forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Picker View

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [GSTSpecimenModel stateMap].count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[GSTSpecimenModel stateMap][row] capitalizedString];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.specimen.state = row;
}

@end
