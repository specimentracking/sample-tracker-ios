//
//  GSTType.h
//  sampletracker
//
//  Created by Ondřej Fabián on 08/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSTSpecimenTypeModel : NSObject <NSCopying>

@property (nonatomic, retain) NSString *type1;
@property (nonatomic, retain) NSString *type2;
@property (nonatomic, retain) NSString *type3;

+ (NSArray *)type1Map;
+ (NSArray *)type2Map;
+ (NSArray *)type3Map;

- (instancetype)initWithIdentifier:(NSString *)typeIdentifier;
- (NSString *)typeIdentifier;


@end
