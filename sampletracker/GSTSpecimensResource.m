//
//  GSTSpecimensResource.m
//  sampletracker
//
//  Created by Ondřej Fabián on 08/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTSpecimensResource.h"

@interface GSTSpecimensResource ()

@property (nonatomic, retain) GSTSpecimenModel *specimen;

@end

@implementation GSTSpecimensResource

//- (NSURL *)resourceURL {
//    return [NSURL URLWithString:[GST_BASE_URL stringByAppendingFormat:@"projects/%@/specimens/", [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_PROJECT_ID]]];
//}

- (void)startCheckSpecimen:(NSString *)barcodeString {
    NSString *urlString = [GST_BASE_URL stringByAppendingFormat:@"projects/%@/check", [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_PROJECT_ID]];
    self.resourceURL = [NSURL URLWithString:urlString];
    self.specimen = [[GSTSpecimenModel alloc] init];
    self.specimen.barCode = barcodeString;
    [self startGetRequestWithParams:[NSDictionary dictionaryWithObject:barcodeString forKey:@"barcode"]];
}

- (void)startPostNewSpecimen:(GSTSpecimenModel *)specimen {
    NSString *urlString = [GST_BASE_URL stringByAppendingFormat:@"projects/%@/specimens/%@", [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_PROJECT_ID], specimen.specimenId];
    self.resourceURL = [NSURL URLWithString:urlString];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:specimen.barCode forKey:@"barcode"];
    [params setObject:specimen.stateString forKey:@"state"];
    [params setObject:specimen.type.typeIdentifier forKey:@"type"];
    [params setObject:specimen.barCode forKey:@"barcode"];
    [params setObject:specimen.location.locationIdentifier forKey:@"location"];
    if (specimen.parent) {
        [params setObject:specimen.parent.specimenId forKey:@"parent_id"];
    }
    [self startPostRequestWithParams:params];
}

- (id)processJSONObject:(id)JSONObject {
    GSTSpecimenModel *specimen;
    if (JSONObject[@"err_code"]) {
        NSInteger errCode = [JSONObject[@"err_code"] integerValue];
        switch (errCode) {
            case 404001:
                specimen = self.specimen;
                break;
            default:
                break;
        }
    } else {
        specimen = [[GSTSpecimenModel alloc] init];
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
    }
    return specimen;
}

@end
