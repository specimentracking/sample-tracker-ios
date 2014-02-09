//
//  GSTTypePickerDelegate.h
//  sampletracker
//
//  Created by Ondrej Fabian on 09/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GSTTypePickerViewController, GSTSpecimenTypeModel;

@protocol GSTTypePickerDelegate <NSObject>

- (void)typePicker:(GSTTypePickerViewController *)picker didPickType:(GSTSpecimenTypeModel *)type;

@end
