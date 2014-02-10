//
//  GSTScanViewController.h
//  sampletracker
//
//  Created by Ondrej Fabian on 10/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingObjC.h"
#import "GSTScanDelegate.h"

@interface GSTScanViewController : UIViewController <ZXCaptureDelegate>

@property (nonatomic, assign) id<GSTScanDelegate> delegate;

@end
