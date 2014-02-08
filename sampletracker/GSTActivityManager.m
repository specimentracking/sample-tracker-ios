//
//  GSTActivityManager.m
//  sampletracker
//
//  Created by Ondřej Fabián on 02/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTActivityManager.h"

@implementation GSTActivityManager

static int activityCount = 0;

+ (void)addActivity {
    @synchronized (self) {
        activityCount++;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}

+ (void)removeActivity {
    @synchronized (self) {
        if (activityCount > 0) {
            activityCount--;
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = activityCount > 0;
    }
}


@end