//
//  GSTLocationPickerViewController.m
//  sampletracker
//
//  Created by Ondřej Fabián on 02/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTLocationPickerViewController.h"

@interface GSTLocationPickerViewController ()

@property (weak, nonatomic) IBOutlet UITextField *fridgeTextField;
@property (weak, nonatomic) IBOutlet UITextField *shelfTextField;
@property (weak, nonatomic) IBOutlet UITextField *rackTextField;
@property (weak, nonatomic) IBOutlet UITextField *boxTextField;
@property (weak, nonatomic) IBOutlet UITextField *spotTextField;

@property (weak, nonatomic) IBOutlet UIStepper *fridgeStepper;
@property (weak, nonatomic) IBOutlet UIStepper *shelfStepper;
@property (weak, nonatomic) IBOutlet UIStepper *rackStepper;
@property (weak, nonatomic) IBOutlet UIStepper *boxStepper;
@property (weak, nonatomic) IBOutlet UIPickerView *spotPicker;

@end

@implementation GSTLocationPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.location) {
        self.fridgeTextField.text = self.location.fridge;
        self.shelfTextField.text = self.location.shelf;
        self.rackTextField.text = self.location.rack;
        self.boxTextField.text = self.location.box;
        self.spotTextField.text = [NSString stringWithFormat:@"%c-%c", [self.location.spot characterAtIndex:0], [self.location.spot characterAtIndex:1]];
        [self.spotPicker selectRow:[self.location.spot characterAtIndex:0]-'A' inComponent:0 animated:NO];
        [self.spotPicker selectRow:[self.location.spot characterAtIndex:1]-'1' inComponent:1 animated:NO];
    } else {
        self.location = [[GSTLocation alloc] init];
        self.location.spot = @"A1";
        self.spotTextField.text = [NSString stringWithFormat:@"A-1"];
        [self.spotPicker selectRow:0 inComponent:0 animated:NO];
        [self.spotPicker selectRow:0 inComponent:1 animated:NO];
    }
}

#pragma mark - Actions

- (IBAction)saveAction:(id)sender {
    self.location.fridge = self.fridgeTextField.text;
    self.location.shelf = self.shelfTextField.text;
    self.location.rack = self.rackTextField.text;
    self.location.box = self.boxTextField.text;
    [self.delegate locationPicker:self didPickLocation:self.location];
}

- (IBAction)stepperValueChanged:(UIStepper *)stepper {
    if (stepper == self.fridgeStepper) {
        self.fridgeTextField.text = [NSString stringWithFormat:@"%.0f", stepper.value];
    } else if (stepper == self.shelfStepper) {
        self.shelfTextField.text = [NSString stringWithFormat:@"%.0f", stepper.value];
    } else if (stepper == self.rackStepper) {
        self.rackTextField.text = [NSString stringWithFormat:@"%.0f", stepper.value];
    } else if (stepper == self.boxStepper) {
        self.boxTextField.text = [NSString stringWithFormat:@"%.0f", stepper.value];
    }
}

#pragma mark - Text field

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return NO;
}

#pragma mark - Picker View

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 9;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = nil;
    if (component == 0) {
        title = [NSString stringWithFormat:@"%c", row+'A'];
    } else if (component == 1) {
        title = [NSString stringWithFormat:@"%i", row+1];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.spotTextField.text = [NSString stringWithFormat:@"%c-%c", row+'A', [self.location.spot characterAtIndex:1]];
        self.location.spot = [NSString stringWithFormat:@"%c%c", row+'A', [self.location.spot characterAtIndex:1]];
    } else if (component == 1) {
        self.spotTextField.text = [NSString stringWithFormat:@"%c-%c", [self.location.spot characterAtIndex:0], row+'1'];
        self.location.spot = [NSString stringWithFormat:@"%c%c", [self.location.spot characterAtIndex:0], row+'1'];
    }
}

@end
