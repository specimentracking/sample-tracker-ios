//
//  GSTLocationPickerDelegate.h
//  sampletracker
//
//  Created by Ondřej Fabián on 02/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GSTLocationPickerViewController, GSTSpecimenLocationModel;

@protocol GSTLocationPickerDelegate <NSObject>

- (void)locationPicker:(GSTLocationPickerViewController *)picker didPickLocation:(GSTSpecimenLocationModel *)location;

@end
