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
    
#if TARGET_IPHONE_SIMULATOR
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.delegate scanner:self didScanTest:@"0120108"];
    });
    return;
#endif
    
    self.capture = [[ZXCapture alloc] init];
    self.capture.rotation = 90.0f;
    self.capture.camera = self.capture.back;
    self.capture.layer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.capture.layer];
    self.capture.delegate = self;
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    @synchronized(self) {        
        if (result && !self.captured) {
            self.captured = YES;
            [self.delegate scanner:self didScanTest:result.text];
            [self.capture stop];
        }
    }
}

- (void)captureSize:(ZXCapture *)capture width:(NSNumber *)width height:(NSNumber *)height {
    
}

@end
