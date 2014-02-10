//
//  GSTSpecimensResource.m
//  sampletracker
//
//  Created by Ondřej Fabián on 08/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTSpecimensResource.h"

@implementation GSTSpecimensResource

//- (NSURL *)resourceURL {
//    return [NSURL URLWithString:[GST_BASE_URL stringByAppendingFormat:@"projects/%@/specimens/", [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_PROJECT_ID]]];
//}

- (void)startCheckSpecimen:(NSString *)barcodeString {
    NSString *urlString = [GST_BASE_URL stringByAppendingFormat:@"projects/%@/specimens/check", [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_PROJECT_ID]];
    self.resourceURL = [NSURL URLWithString:urlString];
    [self startGetRequestWithParams:nil];
}

- (id)processJSONObject:(id)JSONObject {
#warning TODO cover no specimen situation
    GSTSpecimenModel *specimen = [[GSTSpecimenModel alloc] init];
    specimen.barCode = JSONObject[@"bar_code"];
    specimen.createTime = [GSTDateUtility dateWithString:JSONObject[@"create_time"]];
    specimen.specimenId = JSONObject[@"id"];
    specimen.projectId = JSONObject[@"project_id"];
    specimen.updateTime = [GSTDateUtility dateWithString:JSONObject[@"update_time"]];
    
    specimen.dateOfCollection = [GSTDateUtility dateWithShortString:JSONObject[@"sample_data"][@"date_of_collection"]];
    specimen.dateSend = [GSTDateUtility dateWithShortString:JSONObject[@"sample_data"][@"date_sent"]];
    specimen.ddPcrFlag = [JSONObject[@"sample_data"][@"dd_pcr_flag"] isEqualToString:@"true"];
    specimen.family = JSONObject[@"sample_data"][@"family"];
    specimen.genotypeFlag = [JSONObject[@"sample_data"][@"genotype_flag"] isEqualToString:@"true"];
    specimen.haplotypeFlag = [JSONObject[@"sample_data"][@"haplotype_flag"] isEqualToString:@"true"];
    specimen.location = [[GSTSpecimenLocationModel alloc] initWithIdentifier:JSONObject[@"sample_data"][@"location"]];
    specimen.ngsSegFlag = [JSONObject[@"sample_data"][@"ngs_seg_flag"] isEqualToString:@"true"];
    specimen.note = JSONObject[@"sample_data"][@"note"];
    specimen.parentId = JSONObject[@"sample_data"][@"parent_id"];
    specimen.participantDob = [GSTDateUtility dateWithShortString:JSONObject[@"sample_data"][@"participant_dob"]];
    specimen.participantId = JSONObject[@"sample_data"][@"participant_id"];
    specimen.participantRelationship = JSONObject[@"sample_data"][@"participant_relationship"];
    specimen.sangerSeqFlag = [JSONObject[@"sample_data"][@"sanger_seq_flag"] isEqualToString:@"true"];
    specimen.sex = JSONObject[@"sample_data"][@"sex"];
    specimen.stateString = JSONObject[@"sample_data"][@"state"];
    specimen.type = [[GSTSpecimenTypeModel alloc] initWithIdentifier:JSONObject[@"sample_data"][@"type"]];
    
    return specimen;
}

@end
