//
//  GSTRESTResourceDelegate.h
//  sampletracker
//
//  Created by Ondrej Fabian on 07/11/13.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

@class GSTRESTResource;

@protocol GSTRESTResourceDelegate <NSObject>

- (void)request:(GSTRESTResource *)request didFinishWithData:(id)resourceData;
- (void)request:(GSTRESTResource *)request didReceiveHeader:(NSDictionary *)header statusCode:(NSInteger)statusCode;
- (void)request:(GSTRESTResource *)request didFailLoadingWithError:(NSError *)error;

@optional

- (void)requestDidStart:(GSTRESTResource *)request;

@end
