//
//  GSTSpecimensResource.m
//  sampletracker
//
//  Created by Ondřej Fabián on 08/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTSpecimensResource.h"

@implementation GSTSpecimensResource

//- (NSURL *)resourceURL {
//    return [NSURL URLWithString:[GST_BASE_URL stringByAppendingFormat:@"projects/%@/specimens/", [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_PROJECT_ID]]];
//}

- (void)startCheckSpecimen:(NSString *)barcodeString {
    NSString *urlString = [GST_BASE_URL stringByAppendingFormat:@"projects/%@/specimens/check", [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_PROJECT_ID]];
    self.resourceURL = [NSURL URLWithString:urlString];
    [self startGetRequestWithParams:nil];
}

- (id)processJSONObject:(id)JSONObject {
    return nil;
}

@end
