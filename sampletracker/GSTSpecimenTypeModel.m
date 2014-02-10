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
    if (typeIdentifier) {
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

- (NSString *)typeIdentifier {
    return [NSString stringWithFormat:@"%@-%@-%@", self.type1, self.type2, self.type3];
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
