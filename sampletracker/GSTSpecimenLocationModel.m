//
//  GSTLocation.m
//  sampletracker
//
//  Created by Ondřej Fabián on 02/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTSpecimenLocationModel.h"

@implementation GSTSpecimenLocationModel

- (instancetype)initWithIdentifier:(NSString *)locationIdentifier {
    if (locationIdentifier && ![locationIdentifier isKindOfClass:[NSNull class]]) {
        self = [super init];
        if (self) {
            for (NSString *locationComponent in [locationIdentifier componentsSeparatedByString:@"-"]) {
                NSArray *keyVal = [locationComponent componentsSeparatedByString:@"_"];
                [self setValue:keyVal[1] forKey:keyVal[0]];
            }
        }
    } else {
        self = nil;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    GSTSpecimenLocationModel *copyLocation = [[[self class] alloc] init];
    
    if (copyLocation) {
        copyLocation.fridge = [self.fridge copy];
        copyLocation.shelf = [self.shelf copy];
        copyLocation.rack = [self.rack copy];
        copyLocation.box = [self.box copy];
        copyLocation.spot = [self.spot copy];
    }
    
    return copyLocation;
}

- (NSString *)locationIdentifier {
    return [NSString stringWithFormat:@"fridge_%@-shelf_%@-rack_%@-box_%@-spot_%@", self.fridge, self.shelf, self.rack, self.box, self.spot];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@-%@-%@-%@-%@", self.fridge, self.shelf, self.rack, self.box, self.spot];
}

@end
