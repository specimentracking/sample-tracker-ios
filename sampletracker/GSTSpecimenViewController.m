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
#import "GSTSpecimensResource.h"
#import "GSTScanViewController.h"

@interface GSTSpecimenViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *statePicker;

@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (weak, nonatomic) IBOutlet UIButton *createDerivativeSampleButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *createButton;

@property (weak, nonatomic) IBOutlet UILabel *ngsLabel;
@property (weak, nonatomic) IBOutlet UILabel *sgrLabel;
@property (weak, nonatomic) IBOutlet UILabel *genLabel;
@property (weak, nonatomic) IBOutlet UILabel *hapLabel;
@property (weak, nonatomic) IBOutlet UILabel *pcrLabel;

@property (nonatomic, retain) GSTSpecimensResource *specimenResource;
@property (nonatomic, assign) BOOL creatingDerivate;

@end

@implementation GSTSpecimenViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _creatingDerivate = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForm];
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
    } else if ([segue.identifier isEqualToString:@"openScanner"]) {
        GSTScanViewController *scanController = segue.destinationViewController;
        scanController.delegate = self;
    }
}

#pragma mark - Actions

- (IBAction)patchSpecimen:(id)sender {
    self.specimenResource = [[GSTSpecimensResource alloc] initWithDelegate:self];
    [self.specimenResource startPatchUpdateSpecimen:self.specimen];
}

- (IBAction)createDerivate:(id)sender {
    [self performSegueWithIdentifier:@"openScanner" sender:sender];
}

- (IBAction)createSpecimen:(id)sender {
    if ([self.specimen isValidForPost]) {
        self.specimenResource = [[GSTSpecimensResource alloc] initWithDelegate:self];
        [self.specimenResource startPostNewSpecimen:self.specimen];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please fill in all parameters." message:nil delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark - Auxiliary

- (void)enableForm:(BOOL)enable {
    self.statePicker.userInteractionEnabled = enable;
    self.locationButton.enabled = enable;
    self.typeButton.enabled = enable;
    self.createDerivativeSampleButton.enabled = enable;
    self.saveButton.enabled = enable;
    self.createButton.enabled = enable;
}

- (void)setupForm {
    if (!self.specimen.specimenId) {
        self.title = @"New Specimen";
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
        self.title = @"Update Specimen";
        self.ngsLabel.textColor = self.specimen.ngsSegFlag?[UIColor greenColor]:[UIColor blackColor];
        self.sgrLabel.textColor = self.specimen.sangerSeqFlag?[UIColor greenColor]:[UIColor blackColor];
        self.genLabel.textColor = self.specimen.genotypeFlag?[UIColor greenColor]:[UIColor blackColor];
        self.hapLabel.textColor = self.specimen.haplotypeFlag?[UIColor greenColor]:[UIColor blackColor];
        self.pcrLabel.textColor = self.specimen.ddPcrFlag?[UIColor greenColor]:[UIColor blackColor];
        self.createDerivativeSampleButton.hidden = NO;
        self.saveButton.hidden = NO;
        self.createButton.hidden = YES;
    }
    
    [self.locationButton setTitle:self.specimen.location.description?self.specimen.location.description:@"Choose location" forState:UIControlStateNormal];
    [self.typeButton setTitle:self.specimen.type.description?self.specimen.type.description:@"Choose type" forState:UIControlStateNormal];
    [self.statePicker selectRow:self.specimen.state inComponent:0 animated:NO];
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

#pragma mark - Scan delegate

- (void)scanner:(GSTScanViewController *)scanner didScanTest:(NSString *)result {
    [self.navigationController popViewControllerAnimated:NO];
    self.creatingDerivate = YES;
    self.specimenResource = [[GSTSpecimensResource alloc] initWithDelegate:self];
    [self.specimenResource startCheckSpecimen:result];
}

#pragma mark - REST Delegate

- (void)requestDidStart:(GSTRESTResource *)request {
    [self enableForm:NO];
}

- (void)request:(GSTRESTResource *)request didReceiveHeader:(NSDictionary *)header statusCode:(NSInteger)statusCode {

}

- (void)request:(GSTRESTResource *)request didFailLoadingWithError:(NSError *)error {
    [self enableForm:YES];
}

- (void)request:(GSTRESTResource *)request didFinishWithData:(id)resourceData {
    [self enableForm:YES];
    if ([resourceData isKindOfClass:[NSError class]]) {
        NSError *error = resourceData;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Error" message:[error.userInfo[@"msg"] stringByAppendingFormat:@"(%i)", error.code] delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    } else {
        GSTSpecimenModel *newSpecimen = resourceData;
        if (self.creatingDerivate) { // This was a check request when creating a derivative specimen
            self.creatingDerivate = NO;
            if (newSpecimen.specimenId) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Duplicate Error" message:@"Duplicate barcode found - cannot create." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
                [alert show];
            } else {
                newSpecimen.parent = self.specimen;
                self.specimen = newSpecimen;
                [self setupForm];
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
