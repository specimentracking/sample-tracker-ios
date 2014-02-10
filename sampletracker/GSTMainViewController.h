//
//  GSTViewController.h
//  sampletracker
//
//  Created by Ondřej Fabián on 02/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSTScanDelegate.h"

@interface GSTMainViewController : UIViewController <GSTRESTResourceDelegate, GSTScanDelegate>

@end
