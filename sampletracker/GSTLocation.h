//
//  GSTLocation.h
//  sampletracker
//
//  Created by Ondřej Fabián on 02/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSTLocation : NSObject

@property (nonatomic, retain) NSString *fridge; // 1-99
@property (nonatomic, retain) NSString *shelf; // 1-99
@property (nonatomic, retain) NSString *rack; // 1-99
@property (nonatomic, retain) NSString *box; // 1-99
@property (nonatomic, retain) NSString *spot; // A1-I9 (9*9 matrix)

- (instancetype)initWithIdentifier:(NSString *)locationIdentifier;
- (NSString *)locationIdentifier;

@end
