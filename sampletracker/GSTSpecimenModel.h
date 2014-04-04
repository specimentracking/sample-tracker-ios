//
//  GSTSpecimenModel.h
//  sampletracker
//
//  Created by Ondřej Fabián on 08/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSTSpecimenLocationModel.h"
#import "GSTSpecimenTypeModel.h"

typedef NS_ENUM (NSInteger, GSTSpecimenState) {
    GSTSpecimenStateNew = 0,
    GSTSpecimenStateOnroad,
    GSTSpecimenStatePsu,
    GSTSpecimenStateDepleted,
    GSTSpecimenStateLost,
    GSTSpecimenStateDiscarded
};

@interface GSTSpecimenModel : NSObject

@property (nonatomic, strong) NSString *specimenId;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSDate *updateTime;
@property (nonatomic, strong) NSString *barCode;
@property (nonatomic, strong) NSString *projectId;

@property (nonatomic, assign) GSTSpecimenModel *derivate;
@property (nonatomic, strong) GSTSpecimenModel *parent;

//Sample data
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, assign) GSTSpecimenState state;
@property (nonatomic, strong) NSString *stateString; // Convenience property state getter
@property (nonatomic, strong) GSTSpecimenTypeModel *type;
@property (nonatomic, strong) GSTSpecimenLocationModel *location;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *family;
@property (nonatomic, strong) NSString *participantId;
@property (nonatomic, strong) NSString *participantRelationship;
@property (nonatomic, strong) NSDate *participantDob;
@property (nonatomic, strong) NSDate *dateSent;
@property (nonatomic, strong) NSDate *dateOfCollection;
@property (nonatomic, strong) NSString *note;

@property (nonatomic, assign) BOOL genotypeFlag;
@property (nonatomic, assign) BOOL haplotypeFlag;
@property (nonatomic, assign) BOOL sangerSeqFlag;
@property (nonatomic, assign) BOOL ngsSegFlag;
@property (nonatomic, assign) BOOL ddPcrFlag;

+ (NSArray *)stateMap;

- (BOOL)isValidForPost;

@end
