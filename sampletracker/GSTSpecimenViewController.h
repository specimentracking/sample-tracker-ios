//
//  GSTNewSpecimenViewController.h
//  sampletracker
//
//  Created by Ondřej Fabián on 02/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSTLocationPickerDelegate.h"
#import "GSTTypePickerDelegate.h"
#import "GSTScanDelegate.h"

@interface GSTSpecimenViewController : UIViewController <GSTRESTResourceDelegate, GSTLocationPickerDelegate, GSTTypePickerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, GSTScanDelegate>

@property (nonatomic, strong) GSTSpecimenModel *specimen;
@property (nonatomic, strong) GSTSpecimenModel *specimenDerivate;

@end
