//
//  GSTLocationPickerViewController.h
//  sampletracker
//
//  Created by Ondřej Fabián on 02/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSTLocation.h"
#import "GSTLocationPickerDelegate.h"

@interface GSTLocationPickerViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, retain) GSTLocation *location;

@property (nonatomic, weak) id<GSTLocationPickerDelegate> delegate;

@end
