//
//  GSTType.m
//  sampletracker
//
//  Created by Ondřej Fabián on 08/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTSpecimenTypeModel.h"

@implementation GSTSpecimenTypeModel

- (instancetype)initWithIdentifier:(NSString *)typeIdentifier {
    if (typeIdentifier && ![typeIdentifier isKindOfClass:[NSNull class]]) {
        self = [super init];
        if (self) {
            [[typeIdentifier componentsSeparatedByString:@"-"] enumerateObjectsUsingBlock:^(NSString *string, NSUInteger idx, BOOL *stop) {
                switch (idx) {
                    case 0:
                        _type1 = string;
                        break;
                    case 1:
                        _type2 = string;
                        break;
                    case 2:
                        _type3 = string;
                        break;
                    default:
                        break;
                }
            }];
        }
    } else {
        self = nil;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    GSTSpecimenTypeModel *copyType = [[[self class] alloc] init];
    
    if (copyType) {
        copyType.type1 = [self.type1 copy];
        copyType.type2 = [self.type2 copy];
        copyType.type3 = [self.type3 copy];
    }
    
    return copyType;
}

- (NSString *)typeIdentifier {
    NSMutableString *identifier = [self.type1 mutableCopy];
    if (self.type2) {
        [identifier appendFormat:@"-%@", self.type2];
        if (self.type3) {
            [identifier appendFormat:@"-%@", self.type3];
        }
    }
    return identifier;
}

- (NSString *)description {
    return self.typeIdentifier;
}

+ (NSArray *)type1Map {
    return @[@"blood", @"buccal", @"hair", @"breastmilk", @"stool", @"vaginal_swab", @"placenta", @"cord_blood", @"tissue"];
}

+ (NSArray *)type2Map {
    return @[@"dna", @"rna"];
}

+ (NSArray *)type3Map {
    return @[@"amplicon", @"library", @"enriched_mtdna"];
}
@end
