//
//  GSTSpecimenModel.m
//  sampletracker
//
//  Created by Ondřej Fabián on 08/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTSpecimenModel.h"

@interface GSTSpecimenModel ()

@end

@implementation GSTSpecimenModel

+ (NSArray *)stateMap {
    return @[@"new", @"onroad", @"psu", @"depleted", @"lost", @"discarded"];
}

- (NSString *)stateString {
    return [GSTSpecimenModel stateMap][self.state];
}

- (void)setStateString:(NSString *)stateString {
    self.state = [[GSTSpecimenModel stateMap] indexOfObject:stateString];
}

- (BOOL)isValidForPost {
    return YES;
//    return self.location && self.type;
}

@end
