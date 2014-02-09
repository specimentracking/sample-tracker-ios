//
//  GSTType.h
//  sampletracker
//
//  Created by Ondřej Fabián on 08/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSTSpecimenTypeModel : NSObject

@property (nonatomic, retain) NSString *type1;
@property (nonatomic, readonly) NSArray *type1Map;
@property (nonatomic, retain) NSString *type2;
@property (nonatomic, readonly) NSArray *type2Map;
@property (nonatomic, retain) NSString *type3;
@property (nonatomic, readonly) NSArray *type3Map;

- (instancetype)initWithIdentifier:(NSString *)locationIdentifier;
- (NSString *)locationIdentifier;


@end
