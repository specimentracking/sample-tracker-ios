//
//  GSTSpecimenModel.m
//  sampletracker
//
//  Created by Ondřej Fabián on 08/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTSpecimenModel.h"

@interface GSTSpecimenModel ()

@property (nonatomic, readonly) NSArray *stateMap;

@end

@implementation GSTSpecimenModel

- (NSArray *)stateMap {
    return @[@"new", @"onroad", @"psu", @"depleted", @"lost", @"discarded"];
}

- (NSString *)stateString {
    return self.stateMap[self.state];
}

- (void)setStateString:(NSString *)stateString {
    self.state = [self.stateMap indexOfObject:stateString];
}

@end
