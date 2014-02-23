//
//  NSString+Emptiness.m
//  sampletracker
//
//  Created by Ondřej Fabián on 02/07/13.
//  Copyright (c) 2013 Galaxy. All rights reserved.
//

#import "NSString+Emptiness.h"

@implementation NSString (Emptiness)

- (BOOL)notEmpty {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length != 0;
}

@end
