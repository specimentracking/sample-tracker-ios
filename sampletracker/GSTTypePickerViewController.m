//
//  GSTTypePickerViewController.m
//  sampletracker
//
//  Created by Ondrej Fabian on 09/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTTypePickerViewController.h"

@interface GSTTypePickerViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *type1Picker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *type2Segment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *type3Segment;

@end

@implementation GSTTypePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type) {
        [self.type1Picker selectRow:[[GSTSpecimenTypeModel type1Map] indexOfObject:self.type.type1] inComponent:0 animated:NO];
        if (self.type.type2) {
            self.type2Segment.selectedSegmentIndex = [[GSTSpecimenTypeModel type2Map] indexOfObject:self.type.type2];
        }
        if (self.type.type3) {
            self.type3Segment.selectedSegmentIndex = [[GSTSpecimenTypeModel type3Map] indexOfObject:self.type.type3];
        }
    } else {
        self.type = [[GSTSpecimenTypeModel alloc] init];
        self.type.type1 = [GSTSpecimenTypeModel type1Map][0];
    }
}

#pragma mark - Actions

- (IBAction)saveType:(id)sender {
    [self.delegate typePicker:self didPickType:self.type];
}

- (IBAction)segmentValueChanged:(UISegmentedControl *)segment {
    if (segment.selectedSegmentIndex == UISegmentedControlNoSegment) {
        return;
    }
    if (segment == self.type2Segment) {
        NSString *selectedType = [GSTSpecimenTypeModel type2Map][segment.selectedSegmentIndex];
        if ([selectedType isEqualToString:self.type.type2]) {
            segment.selectedSegmentIndex = UISegmentedControlNoSegment;
            selectedType = nil;
            
            // Also clear next segment
            self.type3Segment.selectedSegmentIndex = UISegmentedControlNoSegment;
            self.type.type3 = nil;
        }
        self.type.type2 = selectedType;
    }
    if (segment == self.type3Segment) {
        NSString *selectedType = [GSTSpecimenTypeModel type3Map][segment.selectedSegmentIndex];
        if ([selectedType isEqualToString:self.type.type3]) {
            segment.selectedSegmentIndex = UISegmentedControlNoSegment;
            selectedType = nil;
        } else {
            if (!self.type.type2) {
                self.type.type2 = [GSTSpecimenTypeModel type2Map][0];
                self.type2Segment.selectedSegmentIndex = 0;
            }
        }
        self.type.type3 = selectedType;
    }
}

#pragma mark - Picker View

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [GSTSpecimenTypeModel type1Map].count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = [GSTSpecimenTypeModel type1Map][row];
    title = [title capitalizedString];
    title = [title stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.type.type1 = [GSTSpecimenTypeModel type1Map][row];
}

@end
