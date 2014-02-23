//
//  JBDateUtility.m
//  sampletracker
//
//  Created by Ondřej Fabián on 06/07/2013.
//  Copyright (c) 2013 Galaxy. All rights reserved.
//

#import "GSTDateUtility.h"

@implementation GSTDateUtility



+ (NSDate *)dateWithString:(NSString *)dateString {
    NSDate *date = nil;
    if (dateString && ![dateString isKindOfClass:[NSNull class]]) {
        NSDateFormatter *formatter = [self currentFormatter];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZ";
        date = [formatter dateFromString:dateString];
    }
    return date;
}

+ (NSDate *)dateWithShortString:(NSString *)dateString {
    NSDate *date = nil;
    if (dateString && ![dateString isKindOfClass:[NSNull class]]) {
        NSDateFormatter *formatter = [self currentFormatter];
        formatter.dateFormat = @"MM/dd/yyyy";
        date = [formatter dateFromString:dateString];
    }
    return date;
}

+ (NSString *)stringWithDate:(NSDate *)date {
    NSString *dateString = nil;
    if (date && ![date isKindOfClass:[NSNull class]]) {
        NSDateFormatter *formatter = [self currentFormatter];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZ";
        dateString = [formatter stringFromDate:date];
    }
    return dateString;
}

+ (NSString *)readableStringWithDate:(NSDate *)date short:(BOOL)shortStyle{
    NSString *dateString = nil;
    if (date && ![date isKindOfClass:[NSNull class]]) {
        NSDateFormatter *formatter = [self currentFormatter];
        [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        formatter.dateFormat = nil;
        [formatter setDateStyle:shortStyle?NSDateFormatterShortStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        dateString = [formatter stringFromDate:date];
    }
    return dateString;
}

#pragma mark - Auxilliary

+ (NSDateFormatter *)currentFormatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [self currentLocale];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZ";
    });
    return formatter;
}

+ (NSLocale *)currentLocale  {
    // Chooce locale according to current language
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLocale *locale = nil;
    if ([[language lowercaseString] hasPrefix:@"cs"] || [[language lowercaseString] hasPrefix:@"sk"]) {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"cs_CZ"];
    } else {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    }
    return locale;
}

@end
