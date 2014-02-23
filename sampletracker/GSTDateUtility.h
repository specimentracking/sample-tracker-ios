//
//  JBDateUtility.h
//  sampletracker
//
//  Created by Ondřej Fabián on 06/07/2013.
//  Copyright (c) 2013 Galaxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSTDateUtility : NSObject

+ (NSDate *)dateWithString:(NSString *)dateString;
+ (NSDate *)dateWithShortString:(NSString *)dateString;
+ (NSString *)stringWithDate:(NSDate *)date;
+ (NSString *)readableStringWithDate:(NSDate *)date short:(BOOL)shortStyle;

@end
