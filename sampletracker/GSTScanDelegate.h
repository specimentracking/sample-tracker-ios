//
//  GSTScanDelegate.h
//  sampletracker
//
//  Created by Ondrej Fabian on 10/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GSTScanViewController;

@protocol GSTScanDelegate <NSObject>

- (void)scaner:(GSTScanViewController *)scanner didScanTest:(NSString *)result;

@end
