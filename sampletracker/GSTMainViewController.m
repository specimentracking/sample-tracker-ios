//
//  GSTViewController.m
//  sampletracker
//
//  Created by Ondřej Fabián on 02/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTMainViewController.h"
#import "GSTSpecimensResource.h"
#import "GSTSpecimenViewController.h"
#import "GSTScanViewController.h"

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"openScanner"]) {
        GSTScanViewController *scanController = segue.destinationViewController;
        scanController.delegate = self;
    } else if ([segue.identifier isEqualToString:@"openSpecimen"]) {
        GSTSpecimenViewController *specimenController = segue.destinationViewController;
        specimenController.specimen = sender;
    }
}

#pragma mark - Actions

- (IBAction)scanBarcode:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *projectId = [userDefaults objectForKey:SETTINGS_PROJECT_ID];
    NSString *apiKey = [userDefaults objectForKey:SETTINGS_API_KEY];
    if (projectId.length > 0 && apiKey.length > 0) {
        [self performSegueWithIdentifier:@"openScanner" sender:sender];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please fill in Project ID and API key in Settings befor proceeding" message:nil delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil];
        [alert show];
    }
    
}

#pragma mark - Scan delegate

- (void)scanner:(GSTScanViewController *)scanner didScanTest:(NSString *)result {
    [self.navigationController popViewControllerAnimated:NO];
    
    self.specimensResource = [[GSTSpecimensResource alloc] initWithDelegate:self];
    [self.specimensResource startCheckSpecimen:result];
}

#pragma mark - REST Delegate

- (void)request:(GSTRESTResource *)request didReceiveHeader:(NSDictionary *)header statusCode:(NSInteger)statusCode {
    
}

- (void)request:(GSTRESTResource *)request didFailLoadingWithError:(NSError *)error {
    
}

- (void)request:(GSTRESTResource *)request didFinishWithData:(id)resourceData {
    [self performSegueWithIdentifier:@"openSpecimen" sender:resourceData];
}


@end
