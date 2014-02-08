//
//  GSTViewController.m
//  sampletracker
//
//  Created by Ondřej Fabián on 02/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTMainViewController.h"
#import "GSTSpecimensResource.h"

@interface GSTMainViewController ()

@property (nonatomic, strong) GSTSpecimensResource *specimensResource;

@end

@implementation GSTMainViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.title = @"Galaxy Specimen Tracking";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
}

#pragma mark - Actions

- (IBAction)checkBarcode:(id)sender {
    self.specimensResource = [[GSTSpecimensResource alloc] initWithDelegate:self];
    [self.specimensResource startCheckSpecimen:@"123456"];
}

#pragma mark - REST Delegate

- (void)request:(GSTRESTResource *)request didReceiveHeader:(NSDictionary *)header statusCode:(NSInteger)statusCode {
    
}

- (void)request:(GSTRESTResource *)request didFailLoadingWithError:(NSError *)error {
    
}

- (void)request:(GSTRESTResource *)request didFinishWithData:(id)resourceData {
    
}


@end
