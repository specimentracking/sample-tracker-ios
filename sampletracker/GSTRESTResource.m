//
//  SBPRESTResource.m
//  sampletracker
//
//  Created by Ondrej Fabian on 07/11/13.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTRESTResource.h"
#import "GSTActivityManager.h"
#include <sys/sysctl.h>

@interface GSTRESTResource ()

@property (nonatomic, strong) NSMutableData *recievedData;
@property (nonatomic, strong) NSURLConnection *connection;

@end

@implementation GSTRESTResource

- (id)initWithDelegate:(id<GSTRESTResourceDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Request methods

- (void)startGetRequestWithParams:(NSDictionary *)params {
    [self startHTTPRequestWithMethod:kHTTPMethodGet params:params jsonBody:nil];
}

- (void)startPostRequestWithParams:(NSDictionary *)params {
    [self startHTTPRequestWithMethod:kHTTPMethodPost params:params jsonBody:nil];
}

- (void)startPostRequestWithParams:(NSDictionary *)params jsonBody:(id)jsonObject{
    [self startHTTPRequestWithMethod:kHTTPMethodPostWithQuery params:params jsonBody:jsonObject];
}

- (void)startHTTPRequestWithMethod:(kHTTPMethod)method params:(NSDictionary *)params jsonBody:(id)jsonObject {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.canceled = NO;
    params = [params mutableCopy];
    
    [params setValue:[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_API_KEY] forKey:@"key"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.resourceURL];
    
    // construct request url
    switch (method) {
        case kHTTPMethodGet: {
            NSURL *requestURL;
            NSMutableString *urlString = [[NSMutableString alloc] init];
            for (NSString *key in params.allKeys) {
                id val = [params valueForKey:key];
                NSString *value = [val isKindOfClass:[NSString class]]?val:[val stringValue];
                NSString *keyValuePair = [key stringByAppendingFormat:@"=%@", [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                [urlString appendFormat:@"&%@", keyValuePair];
            }
            if (urlString.length > 0) { // trim the initial '&'
                [urlString deleteCharactersInRange:NSMakeRange(0, 1)];
            }
            
            NSString *fullURLString = [self.resourceURL.absoluteString stringByAppendingFormat:@"?%@", urlString];
            requestURL = [NSURL URLWithString:fullURLString];
            request = [NSMutableURLRequest requestWithURL:requestURL];

            [request setHTTPMethod:@"GET"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        } break;
        case kHTTPMethodPost: {
            // set the data and the content length
            NSMutableString *postData = [NSMutableString stringWithString:@""];
            NSString *key;
            for (key in params.allKeys) {
                CFStringRef str = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)params[key], NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
                [postData appendFormat:@"%@=%@&", [key stringByReplacingOccurrencesOfString:@" " withString:@"+"], (__bridge NSString *)str];
                CFRelease(str);
            }
            [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPMethod:@"POST"];
        } break;
        case kHTTPMethodPostWithQuery: {
            NSURL *requestURL;
            NSMutableString *urlString = [NSMutableString string];
            for (NSString *key in params.allKeys) {
                id val = [params valueForKey:key];
                NSString *value = [val isKindOfClass:[NSString class]]?val:[val stringValue];
                NSString *keyValuePair = [key stringByAppendingFormat:@"=%@", [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                [urlString appendFormat:@"&%@", keyValuePair];
            }
            if (urlString.length > 0) { // trim the initial '&'
                urlString = [NSMutableString stringWithString:[urlString substringFromIndex:1]];
            }
            
            NSString *fullURLString = [self.resourceURL.absoluteString stringByAppendingFormat:@"?%@", urlString];
            requestURL = [NSURL URLWithString:fullURLString];
            request = [NSMutableURLRequest requestWithURL:requestURL];

            if (jsonObject) {
                NSData *postData = [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:nil];
                [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
                [request setHTTPBody:postData];
            }
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPMethod:@"POST"];
        } break;
        default:
            break;
    }
    
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *userAgent = [NSString stringWithFormat:@"sampletracker/%@/iOS/%@/%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], [[UIDevice currentDevice] systemVersion], [NSString stringWithCString:model encoding:NSUTF8StringEncoding]];
    free(model);
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"AppDelegate" forHTTPHeaderField:@"X-Statistic-Context"];
    
    // add language to the request
//    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
//    if ([[language lowercaseString] hasPrefix:@"cs"] || [[language lowercaseString] hasPrefix:@"sk"]) {
//        language = @"cs";
//    } else {
//        language = @"en";
//    }
//    [request addValue:language forHTTPHeaderField:@"Accept-Language"];
    
    self.recievedData = [NSMutableData data];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    [GSTActivityManager addActivity];
    
    if ([self.delegate respondsToSelector:@selector(requestDidStart:)]) {
        [self.delegate performSelector:@selector(requestDidStart:) withObject:self];
	}
}

- (void)cancelRequest {
    @synchronized (self) {
        if (!self.isCanceled) {
            [GSTActivityManager removeActivity];
            self.canceled = YES;
            [self.connection cancel];
        }
    }
}

#pragma mark - Resource

- (id)processJSONObject:(id)JSONObject {
    return JSONObject;
}

#pragma mark - URL connection data delegate

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    @synchronized (self) {
        if (!self.isCanceled) {
            NSError *parserError;
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:self.recievedData options:0 error:&parserError];
            if (parserError) {
                [self.delegate request:self didFailLoadingWithError:parserError];
            } else {
                [self.delegate request:self didFinishWithData:[self processJSONObject:jsonObject]];
            }
            [GSTActivityManager removeActivity];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    @synchronized (self) {
        [GSTActivityManager removeActivity];
        if (!self.isCanceled && [self.delegate respondsToSelector:@selector(request:didFailLoadingWithError:)]) {
            [self.delegate request:self didFailLoadingWithError:error];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.recievedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    @synchronized (self) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if ([self.delegate respondsToSelector:@selector(request:didReceiveHeader:statusCode:)]) {
            [self.delegate request:self didReceiveHeader:httpResponse.allHeaderFields statusCode:httpResponse.statusCode];
        }
    }
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    BOOL trustServer = NO;
    SecTrustRef trust = challenge.protectionSpace.serverTrust;
    if (trust) {
//        SecCertificateRef certRef = SecTrustGetCertificateAtIndex(challenge.protectionSpace.serverTrust, 0);
//        NSData *serverCertificateData = (__bridge NSData *)SecCertificateCopyData(certRef);
//        NSString *serverCertificateDataHash = [[serverCertificateData stringUsingBase64Encoding] SHA256];
//        if ([serverCertificateDataHash isEqual:CERT_HASH_TCWS] || [serverCertificateDataHash isEqual:CERT_HASH_STS]) {
            trustServer = YES;
//        }
    }
    
#ifdef DEBUG_CERTIFICATES
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
#else
    if (trustServer) {
        [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    } else {
        [challenge.sender cancelAuthenticationChallenge:challenge];
    }
#endif
}

@end

