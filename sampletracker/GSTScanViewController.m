//
//  GSTScanViewController.m
//  sampletracker
//
//  Created by Ondrej Fabian on 10/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "GSTScanViewController.h"

@interface GSTScanViewController ()

@property (nonatomic, strong) ZXCapture *capture;
@property (nonatomic, assign) BOOL captured;

@end

@implementation GSTScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Scanning";
    
    self.capture = [[ZXCapture alloc] init];
    self.capture.rotation = 90.0f;
    
    // Use the back camera
    self.capture.camera = self.capture.back;
    
    self.capture.layer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.capture.layer];
    
    self.capture.delegate = self;
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    @synchronized(self) {        
        if (result && !self.captured && result.barcodeFormat == kBarcodeFormatAztec) {
            self.captured = YES;
            [self.delegate scaner:self didScanTest:result.text];
            [self.capture stop];
        }
    }
}

- (void)captureSize:(ZXCapture *)capture width:(NSNumber *)width height:(NSNumber *)height {
    
}

@end
