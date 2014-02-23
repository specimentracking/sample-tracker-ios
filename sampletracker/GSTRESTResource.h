//
//  GSTRESTResource.h
//  sampletracker
//
//  Created by Ondrej Fabian on 07/11/13.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTRESTResourceDelegate.h"

#ifdef ENV_PROD
    #define GST_BASE_URL [[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_BASE_URL] notEmpty]?[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_BASE_URL]:@"https://gateway.developer.telekom.com/plone/telefoniecenter/rest/v1/"
#endif

#ifdef ENV_TEST
    #define GST_BASE_URL [[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_BASE_URL] notEmpty]?[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_BASE_URL]:@"http://samples.galaxyproject.org/api/"
#endif

#ifdef ENV_MOCK
    #define GST_BASE_URL [[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_BASE_URL] notEmpty]?[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_BASE_URL]:@"http://galaxysampletracking.apiary.io/api/"
#endif

typedef NS_ENUM(NSInteger, kHTTPMethod) {
    kHTTPMethodUnknown,
    kHTTPMethodGet,
    kHTTPMethodPost,
    kHTTPMethodPatch,
    kHTTPMethodPostWithQuery
};

@interface GSTRESTResource : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (nonatomic, strong) id<GSTRESTResourceDelegate> delegate;
@property (nonatomic, getter = isCanceled) BOOL canceled;
@property (nonatomic, strong) NSURL *resourceURL;

- (id)initWithDelegate:(id<GSTRESTResourceDelegate>)delegate;

// Request
- (void)startGetRequestWithParams:(NSDictionary *)params;
- (void)startPatchRequestWithParams:(NSDictionary *)params;
- (void)startPostRequestWithParams:(NSDictionary *)params;
- (void)startPostRequestWithParams:(NSDictionary *)params jsonBody:(id)jsonObject;
- (void)startHTTPRequestWithMethod:(kHTTPMethod)method params:(NSDictionary *)params jsonBody:(id)jsonObject;
- (void)cancelRequest;

// Resource
- (id)processJSONObject:(id)JSONObject;
- (NSURL *)resourceURL;

@end
