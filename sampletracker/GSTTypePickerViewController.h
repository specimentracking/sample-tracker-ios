//
//  GSTTypePickerViewController.h
//  sampletracker
//
//  Created by Ondrej Fabian on 09/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSTTypePickerDelegate.h"
#import "GSTSpecimenTypeModel.h"

@interface GSTTypePickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, copy) GSTSpecimenTypeModel *type;

@property (nonatomic, weak) id<GSTTypePickerDelegate> delegate;

@end
